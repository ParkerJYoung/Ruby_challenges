def solution(array, k)
  index = 0
  length = array.length
  for index in 0 .. (length - 2)
      if (array[index] + 1 < array[index + 1]) then
          return false
      end
  end
  if (array[0] != 1) || (array[-1] != k) then
      return false
  else
      return true
  end
end


array = [1,2,3,4,5]
num = 4

puts solution(array, num)