# Write a function that will flatten an array of arbitrarily nested arrays of integers into a flat array of integers.
# e.g. [[1,2,[3]],4] → [1,2,3,4]. If the language you're using has a function to flatten arrays, you should pretend it doesn't exist.

# Excellent answers have a complete test suite covering empty lists, invalid input, null-hostile checks.
# If this code was in a code review on your team you’d spend time picking a well deserved “ship it” emoji or GIF.

def is_array? array
  array.class == Array
end

def flatten array
  if !is_array? array
    raise ArgumentError.new "Unexpected input: #{array.class}. Expected an Array."
  end

  flattened_array = []

  array.each do |item|
    if item.class == Array
      flattened_array = flattened_array + (flatten item)
    else
      flattened_array.push item
    end
  end

  flattened_array
end

puts flatten [1,[2,[[[[42,[[[[9],8]]]]]]]],3]