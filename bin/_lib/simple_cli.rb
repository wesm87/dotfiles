# frozen_string_literal: true

require_relative 'utils'

# Both stdin and args will be included in parsed args
PARSE_ARG_MODE_INCLUSIVE = 'INCLUSIVE'

# Use stdin only if it exists, otherwise use args only
PARSE_ARG_MODE_EXCLUSIVE = 'EXCLUSIVE'

###
# SimpleCLI
###
class SimpleCLI
  attr_reader :parse_args_mode

  def initialize(parse_args_mode = PARSE_ARG_MODE_INCLUSIVE)
    @parse_args_mode = parse_args_mode

    exit unless args?
  end

  def args?
    stdin_items_and_args.any?
  end

  def argv_args
    @argv_args ||= ARGV.any? ? ARGV : []
  end

  def flag_arg?(str)
    starts_with?('--', str)
  end

  def not_flag_arg?(str)
    !flag_arg?(str)
  end

  def to_flag_arg(str)
    flag_arg?(str) ? str : "--#{str}"
  end

  def flags_list_to_hash(flags)
    flags.map { |flag| [flag, true] }.to_h
  end

  def stdin_lines
    @stdin_lines ||= parse_stdin_lines
  end

  def parse_stdin_lines
    lines = $stdin.tty? ? [] : $stdin.readlines(chomp: true)
    lines.map do |line|
      boundary = line =~ ANY_QUOTE_REGEXP ? ANY_QUOTE_REGEXP : ''
      line.split(boundary).reject { |item| item.nil? || item.strip.empty? }
    end
  end

  def stdin_items_and_args
    @stdin_items_and_args ||= parse_stdin_items_and_args
  end

  def parse_stdin_items_and_args
    if stdin_lines.any?
      stdin_lines.map { |line| line + argv_args }.flatten
    else
      argv_args
    end
  end

  def args_hash
    @args_hash ||= parse_args_hash
  end

  def parse_args_hash
    positional, flags = partition(:not_flag_arg?, stdin_items_and_args)
    flags_hash = flags_list_to_hash(flags)
    groups_hash = {
      'positional' => positional,
      'flags' => flags
    }

    {}.merge(groups_hash, flags_hash)
  end

  def positional
    args_hash['positional']
  end

  def flag(flag)
    args_hash[to_flag_arg(flag)]
  end

  def for_each_arg(func = nil, &block)
    callback = get_callback(block, func)

    return if callback.nil?

    stdin_items_and_args.each do |arg|
      callback.call(arg)
    end
  end

  def puts_for_each_arg(func = nil, &block)
    callback = get_callback(block, func)

    return if callback.nil?

    for_each_arg do |arg|
      puts callback.call(arg)
    end
  end
end
