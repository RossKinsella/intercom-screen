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
    elsif item.class != NilClass
      flattened_array.push item
    end
  end

  flattened_array
end
