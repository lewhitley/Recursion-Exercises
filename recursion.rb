require 'byebug'

def range(start, end_val)
  return [] if end_val < start
  return [] if start == end_val - 1
  result = [start+1]
  result.push(*range(start + 1, end_val))
  result
end

#p range(1, 10)


def sum_r(arr)
  sum = 0
  return 0 if arr == []
  sum += arr.shift + sum_r(arr)
  sum
end

# p sum_r([1,2,3])
# p sum_r(Array.new(1000,10))

def sum_i(arr)
  sum = 0
  arr.each {|el| sum += el}
  sum
end

# p sum_i([1,2,3])
# p sum_i(Array.new(1000,10))


def exponent_recursive(base, number)
  return 1 if number == 0
  base * exponent_recursive(base, number -1)
  p base
end

# p exponent_recursive(1,12)
# p exponent_recursive(2,1)
# p exponent_recursive(1,0)
# p exponent_recursive(100,3)
# p exponent_recursive(10,100)

def exponent2(base, number)
  return 1 if number == 0
  return base if number == 1
  if number.even?
    p base
    half_exponent = exponent2(base, number/2)
    half_exponent * half_exponent
  else
    p base
    half_odd = exponent2(base, (number-1)/2)
    base * half_odd * half_odd
  end
end

#p exponent2(1,12)
#p exponent2(2,1)
#p exponent2(1,0)
#p exponent2(100,3)
#p exponent2(10,100)

class Array
  def deep_dup
    copy=[]
    self.each do |el|
      if el.is_a?(Array)
        copy.push(el.deep_dup)
      elsif el.is_a?(Fixnum)
        copy.push(el)
      else
        copy.push(el.dup)
      end
    end
    copy
  end
end

# a = [1, [2], [3, [4]]]
# b = a.deep_dup
# a[2][1] = 2
# p a
# p b

def fibonacci(n)
  return [1] if n == 1
  return [1,1] if n == 2
  return [] if n < 1
  previous_fib=fibonacci(n-1)
  fib = previous_fib << (previous_fib[-1] + previous_fib[-2])
  fib
end

# p fibonacci(0)
# p fibonacci(1)
# p fibonacci(2)
# p fibonacci(3)
# p fibonacci(4)
# p fibonacci(10)
# p fibonacci(1000)

def bsearch(array, target)
  mid_idx = array.length/2
  return mid_idx if array[mid_idx] == target
  return nil if array.length <= 1 && array.first != target
  if array[mid_idx] > target
    left = array[0...mid_idx]
    bsearch(left, target)
  elsif array[mid_idx] < target
    right = array[mid_idx + 1..-1]
    bsearch(right, target) + mid_idx + 1 if bsearch(right, target)
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
# p bsearch([1, 2, 3, 4, 5, 7,8,9,10,11], 7) # => nil

def merge_sort(arr)
  return arr if arr.length <= 1
  mid_idx = arr.length / 2
  left = arr[0...mid_idx]
  right = arr[mid_idx .. -1]
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)
  merge(sorted_left, sorted_right)
end

def merge(arr1, arr2 = [])
  return arr1 if arr2 == []
  return arr2 if arr1 == []
  merged = []
  if arr1.first <= arr2.first
    merged << arr1.shift
  else
    merged << arr2.shift
  end
  merged << merge(arr1,arr2)
  merged.flatten
end

# p merge_sort([38,27,43,3,9,82,10])
# p merge_sort([38,27])

def subsets(array)
  subs = [[]]
  array.each_with_index do |el , i|
    subsets(array[0...i]).each do |sub_arr|
      sub_arr << el
      subs << sub_arr
    end
  end
  subs
end


# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([2,4,1,5])


def make_change_greed(amount, coins=[1, 5, 10, 25])
  return [] if amount == 0
  coins.sort!
  change=[]
  if amount >= coins.max
    change.push(coins.max)
    amount -= coins.max
  else
    coins.pop
  end
  change.push(make_change_greed(amount, coins))
  change.flatten

end

# p make_change_greed(24, [10, 7, 1])

def make_better_change(amount, coins=[1,5,10,25])
  return [] if amount == 0
  best_combo_value= nil
  coins.each do |coin|
    change=[]
    if coin <= amount
      change.push(coin)
      remainder = amount - coin
      change=change.concat(make_better_change(remainder, coins))
      if best_combo_value == nil
        best_combo_value = change
      elsif change.length < best_combo_value.length
        best_combo_value = change
      end
    end
  end
  best_combo_value
end

p make_better_change(24, [10, 7, 1])
