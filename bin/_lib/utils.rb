# frozen_string_literal: true

ANY_QUOTE_REGEXP = /['"]/.freeze

def identity(val)
  val.itself
end

def func?(func = nil)
  !func.nil? && func.is_a?(Symbol)
end

def get_callback(block, func)
  func?(func) ? method(func) : block
end

def merge_hashes(hash_a, hash_b)
  {}.merge(hash_a, hash_b)
end

def to_pair(val)
  [val, val]
end

def list_to_hash(list)
  list.map { |item| to_pair(item) }.to_h
end

def to_lower_case(str)
  str.downcase
end

def starts_with?(needle, haystack)
  haystack.start_with?(needle)
end

def partition(predicate, iterable)
  iterable.partition { |item| method(predicate).call(item) }
end

def str_contains_with?(func, needle, haystack)
  method(func).call(haystack).include?(method(func).call(needle))
end

def str_contains?(needle, haystack, ignore_case: false)
  str_contains_with?(ignore_case ? :to_lower_case : :identity, needle, haystack)
end

def char_count(str)
  str.strip.length
end

def slugify(str)
  str.strip
    .gsub(/[^a-zA-Z0-9]+/, '-')
    .gsub(/[^a-zA-Z0-9]+$/, '')
    .gsub(/^[^a-zA-Z0-9]+/, '')
    .downcase
end

def for_each(callback, iterable)
  iterable.each do |item|
    method(callback).call(item)
  end
end

def puts_for_each(callback, iterable)
  iterable.each do |item|
    puts method(callback).call(item)
  end
end

def cli_is_flag_arg?(str)
  starts_with?('--', str)
end

def cli_not_flag_arg?(str)
  !cli_is_flag_arg?(str)
end

def cli_input_lines
  ARGV.any? ? ARGV : $stdin.readlines
end

def cli_args
  ARGV.any? ? ARGV : []
end

def puts_for_each_cli_input_line(callback)
  puts_for_each(callback, cli_input_lines)
end

def cli_stdin_items_for_line(line)
  boundary = line =~ ANY_QUOTE_REGEXP ? ANY_QUOTE_REGEXP : ''
  line.split(boundary).reject! { |item| item.nil? || item.strip.empty? }
end

def cli_stdin_lines
  if $stdin.tty?
    []
  else
    result = $stdin
      .readlines(chomp: true)
      .map { |line| cli_stdin_items_for_line(line) }
    puts "cli_stdin_lines: #{result.inspect}"
    result
  end
end

def cli_stdin_items_and_args
  result = cli_stdin_lines.map { |line| line + cli_args }
  puts result.inspect
  result
end

def cli_args_hash
  all_args = cli_stdin_items_and_args
  args_pairs = partition(:cli_not_flag_arg?, all_args)

  puts args_pairs.inspect

  positional, flags = args_pairs
  result = {
    'positional' => positional,
    'flags' => flags
  }

  puts result

  result
end
