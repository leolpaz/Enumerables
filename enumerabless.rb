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
    return false unless block_given?    
    while i < arr.length
      temp_arr.push(arr[i]) if yield arr[i]
      i += 1
    end
    temp_arr
  end 

  def my_all?
    i = 0
    arr = to_a
    return false unless block_given?  
    while i < arr.length
      return false unless yield arr[i]
      i += 1
    end
    return true
  end
  
  def my_any?
    i = 0
    arr = to_a
    return false unless block_given?
    while i < arr.length
      return true if yield arr[i]
      i += 1
    end
    return false
  end
  
  def my_none?
    i = 0
    arr = to_a
    return false unless block_given?
    while i < arr.length
      return false if yield arr[i]
      i += 1
    end
    return true
  end

  def my_count(param = nil)
    i = 0
    arr = to_a
    counter = 0
    my_each{|number| counter += 1 if number == param} unless param.nil?
    return counter unless param.nil?
    return arr.length unless block_given?
    counter = 0
    while i < arr.length
      counter += 1 if yield arr[i]
      i += 1
    end
    counter
  end
end

a.my_each{|number|}

a.my_each_with_index{|number, index|}

a.my_select{|number|}

a.my_all?{|number|}

a.my_any?{|number|}

a.my_none?{|number|}

p a.my_count{|number|}






