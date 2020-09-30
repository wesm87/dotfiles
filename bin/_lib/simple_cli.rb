# frozen_string_literal: true

require_relative 'utils'

ANY_QUOTE_REGEXP = /['"]/.freeze
HAS_SINGLE_QUOTES_REGEXP = /'[^'"]*'/.freeze
HAS_DOUBLE_QUOTES_REGEXP = /"[^'"]*"/.freeze

# Both stdin and args will be included in parsed args
PARSE_ARGS_MODE_INCLUSIVE = 'INCLUSIVE'

# Use stdin only if it exists, otherwise use args only
PARSE_ARGS_MODE_EXCLUSIVE = 'EXCLUSIVE'

STDIN_SEPARATOR_NEWLINE = 'NEWLINE'
STDIN_SEPARATOR_WHITESPACE = 'WHITESPACE'
STDIN_SEPARATOR_QUOTES = 'QUOTES'

###
# SimpleArgsParser
# TODO:1 When parse_args_mode is PARSE_ARGS_MODE_INCLUSIVE, treat stdin / argv
# TODO:1 as separate lines of input and exclude flags from the argv input line.
# TODO:2 allow short-hand flags (e.g. -i instead of --ignore-case).
###
class SimpleArgsParser
  attr_reader :parse_args_mode, :stdin_separator

  def initialize(
    parse_args_mode = PARSE_ARGS_MODE_INCLUSIVE,
    stdin_separator = STDIN_SEPARATOR_QUOTES
  )
    @parse_args_mode = parse_args_mode
    @stdin_separator = stdin_separator
  end

  def has_args?
    parsed_args.any?
  end

  def parsed_args
    stdin_items_and_args
  end

  def is_flag_arg?(str)
    starts_with?('--', str)
  end

  def is_not_flag_arg?(str)
    !is_flag_arg?(str)
  end

  def to_flag_arg(str)
    is_flag_arg?(str) ? str : "--#{str}"
  end

  def argv_args
    @argv_args ||= ARGV.any? ? ARGV : []
  end

  def stdin_lines
    @stdin_lines ||= parse_stdin_lines
  end

  def trim_and_compact_lines(lines)
    lines
      .reject(&:nil?)
      .map(&:strip)
      .reject { |line| line.strip.empty? }
  end

  def get_stdin_line_split_boundary(line)
    split_by_whitespace = stdin_separator == STDIN_SEPARATOR_WHITESPACE
    split_by_quotes = stdin_separator == STDIN_SEPARATOR_QUOTES

    return ' ' if split_by_whitespace

    if split_by_quotes && line =~ HAS_DOUBLE_QUOTES_REGEXP
      '\''
    elsif split_by_quotes && line =~ HAS_SINGLE_QUOTES_REGEXP
      '"'
    else
      ' '
    end
  end

  def split_stdin_line(line)
    boundary = get_stdin_line_split_boundary(line)
    split_by_newlines = stdin_separator == STDIN_SEPARATOR_NEWLINE
    lines_list = split_by_newlines ? [line] : line.split(boundary)

    trim_and_compact_lines(lines_list)
  end

  def parse_stdin_lines
    lines = $stdin.tty? ? [] : $stdin.readlines(chomp: true)

    lines.map { |line| split_stdin_line(line) }
  end

  def parse_stdin_items_and_args
    return argv_args if stdin_lines.empty?
    return stdin_lines.flatten if parse_args_mode == PARSE_ARGS_MODE_EXCLUSIVE

    stdin_lines.map { |line| line + argv_args }.flatten
  end

  def stdin_items_and_args
    @stdin_items_and_args ||= parse_stdin_items_and_args
  end

  def args_groups_hash
    @args_groups_hash ||= parse_args_groups_hash
  end

  def parse_args_groups_hash
    params, flags = partition(:is_not_flag_arg?, stdin_items_and_args)

    {
      'params' => params,
      'flags' => flags
    }
  end

  def args_params_list
    @args_params_list ||= args_groups_hash['params']
  end

  def args_flags_list
    @args_flags_list ||= args_groups_hash['flags']
  end

  def args_flags_hash
    @args_flags_hash ||= args_flags_list.zip(args_flags_list).to_h
  end

  def args_hash
    @args_hash ||= merge_hashes(args_groups_hash, args_flags_hash)
  end

  def get_params
    args_params_list
  end

  def get_flags
    args_flags_list
  end

  def has_flag(flag)
    args_hash.has_key?(to_flag_arg(flag))
  end
end

###
# SimpleCLI
###
class SimpleCLI
  attr_reader :args_parser, :parsed_args

  def initialize(
    parse_args_mode = PARSE_ARGS_MODE_INCLUSIVE,
    stdin_separator = STDIN_SEPARATOR_QUOTES
  )
    @args_parser = SimpleArgsParser.new(parse_args_mode, stdin_separator)
    @parsed_args = args_parser.parsed_args

    exit unless has_args?
  end

  def has_args?
    args_parser.has_args?
  end

  def get_params
    args_parser.get_params
  end

  def get_flags
    args_parser.get_flags
  end

  def has_flag(flag)
    args_parser.has_flag(flag)
  end

  def for_each_arg(func = nil, &block)
    for_each(func || block, parsed_args)
  end

  def puts_for_each_arg(func = nil, &block)
    puts_for_each(func || block, parsed_args)
  end
end
