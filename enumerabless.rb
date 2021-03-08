a = [2, 4, 6, 8, 10, 20]


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

  def my_map
    i = 0
    arr = to_a
    temp_arr = []
    return to_enum(:my_map) unless block_given?
    while i < arr.length
      temp_arr.push(yield arr[i])
      i += 1
    end
    temp_arr
  end

  def my_inject(*param)
    i = 0
    arr = to_a
    acumulator = 0 if param.empty?
    acumulator = param[0] if param[0].class == Integer
    unless param.empty?
      if param[0].class == Integer and param[1].class == Symbol
        acumulator = param[0].to_i
        while i < arr.length
          acumulator = param[1].to_proc.call(acumulator, arr[i])
          i += 1
        end
      elsif param[0].class == Symbol
        acumulator = 0
        while i < arr.length
          acumulator = param[0].to_proc.call(acumulator, arr[i])
          i += 1
          p acumulator
        end
      end
      return acumulator
    end
    while i < arr.length
      acumulator = yield acumulator, arr[i]
      i += 1
    end
    acumulator
  end
  
end
def multiply_els(arr)
  arr.my_inject(1, :*)
end

a.my_each{|number|}

a.my_each_with_index{|number, index|}

a.my_select{|number|}

a.my_all?{|number|}

a.my_any?{|number|}

a.my_none?{|number|}

a.my_count{|number|}

a.my_map{|number|}

p multiply_els(a)








