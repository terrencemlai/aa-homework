require "byebug"

fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']


def sluggish_octopus(arr)    
    i = 0
    while i < arr.length - 1
        if arr[i].length > arr[i+1].length
            arr[i], arr[i+1] = arr[i+1], arr[i]
            i = 0
        else
            i += 1
        end
    end
    arr.last
end

# p sluggish_octopus(fish)


def dominant_octopus(arr)
    return arr if arr.length < 2
    pivot = arr.shift
    left = arr.select { |word| word.length <= pivot.length }
    right = arr.select { |word| pivot.length < word.length }
    # debugger
    final = dominant_octopus(left) + [pivot] + dominant_octopus(right)
end

# p dominant_octopus(fish).last


def clever_octopus(arr)
    arr.inject do |acc, el|
        if acc.length < el.length
            el
        else 
            acc
        end
    end
end

# p clever_octopus(fish)


tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(move, tiles_array)
    i = 0
    tiles_array.each_with_index { |ele, idx| i = idx if ele == move }
    i
end

p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

new_tiles_data_structure = { "up" => 0,
                             "right-up" => 1,
                             "right" => 2,
                             "right-down" => 3,
                             "down" => 4,
                             "left-down" => 5,
                             "left" => 6,
                             "left-up" =>7 }

def constant_dance(move, new_tiles_data_structure)
    new_tiles_data_structure[move]
end

p constant_dance("up", new_tiles_data_structure)
p constant_dance("right-down", new_tiles_data_structure)
