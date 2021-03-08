a = [2, 4, 6, 8, 10]


module Enumerable
  def my_each
    return to_enum unless block_given?
    i = 0
    arr = to_a
    while i < arr.length
      yield arr[i]
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    i = 0
    arr = to_a
    while i < arr.length
      yield arr[i], i
      i += 1
    end
  end
  
  def my_select
  i = 0
  arr = to_a
  temp_arr = []
  while i < arr.length
    temp_arr.push(arr[i]) if yield arr[i]
    i += 1
  end
  temp_arr
  end 

  def my_all?
    i = 0
    arr = to_a
    while i < arr.length
      return false unless yield arr[i]
      i += 1
    end
    return true
  end
  
  def my_any?
    i = 0
    arr = to_a
    while i < arr.length
      return true if yield arr[i]
      i += 1
    end
    return false
  end  
end

a.my_each{|number|}

a.my_each_with_index{|number, index|}

a.my_select{|number|}

a.my_all?{|number|}

a.my_any?{|number|}

p a.none?{|number| number % 7 == 0}


