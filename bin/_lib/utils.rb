# frozen_string_literal: true

BLANK_STRING_REGEXP = /^[[:space:]]*$/.freeze

def get_callable(func, block = nil)
  return block if block
  return method(func) if func.is_a?(String) || func.is_a?(Symbol)

  func&.to_proc || func || nil
end

def identity(val)
  val.itself
end

def equals_any?(vals_list, val)
  vals_list.include?(val)
end

def any?(predicate, iterable)
  callable_method = get_callable(predicate)

  return iterable if callable_method.nil?

  iterable.any? { |item| callable_method[item] }
end

def any_pass?(predicates_iterable, val)
  predicates_iterable.any? do |predicate|
    callable_method = get_callable(predicate)

    return val if callable_method.nil?

    callable_method[val]
  end
end

def is_type?(type, val)
  val.is_a?(type)
end

def is_any_type?(types, val)
  !val.nil? && types.any? { |type| val.is_a?(type) }
end

def is_symbol?(val)
  is_any_type?([Symbol], val)
end

def is_string?(val)
  is_any_type?([String], val)
end

def is_boolean?(val)
  equals_any?([true, false], val)
end

def is_empty?(val)
  return true if val.nil?
  return !val if is_boolean?(val)
  return false if is_any_type?([Numeric, Time], val)

  val.empty?
end

def is_blank?(val)
  return is_empty?(val) unless is_string?(val)

  is_empty?(val) || BLANK_STRING_REGEXP.match?(val)
end

def merge_hashes(hash_a, hash_b)
  {}.merge(hash_a, hash_b)
end

def to_lower_case(str)
  str.downcase
end

def starts_with?(needle, haystack)
  haystack.start_with?(needle)
end

def partition(predicate, iterable)
  callable_method = get_callable(predicate)

  return iterable if callable_method.nil?

  iterable.partition { |item| callable_method[item] }
end

def str_contains_with?(func, needle, haystack)
  callable_method = get_callable(func)

  return false if callable_method.nil?

  needle_result = callable_method[needle]
  haystack_result = callable_method[haystack]

  haystack_result.include?(needle_result)
end

def str_contains?(needle, haystack, ignore_case: false)
  func = ignore_case ? :to_lower_case : :identity

  str_contains_with?(func, needle, haystack)
end

def char_count(str)
  str.strip.length
end

###
# - @ -> at
# - & -> and
# - replace non-alphanumeric characters with spaces
# - strip leading and trailing spaces
# - convert whitespace character(s) to a dash
# - convert to lower-case
###
def slugify(str)
  str
    .gsub(/\s*@\s*/, ' at ')
    .gsub(/\s*&\s*/, ' and ')
    .gsub(/[^a-zA-Z0-9]+/, ' ')
    .strip
    .gsub(/\s+/, '-')
    .downcase
end

def for_each(func, iterable)
  callable_method = get_callable(func)

  return iterable if callable_method.nil?

  iterable.each do |item|
    callable_method[item]
  end
end

def puts_for_each(func, iterable)
  callable_method = get_callable(func)

  return iterable if callable_method.nil?

  iterable.each do |item|
    puts callable_method[item]
  end
end
