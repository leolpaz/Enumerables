# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield arr[i], i
      i += 1
    end
    self
  end

  def my_select
    i = 0
    arr = to_a
    temp_arr = []
    return to_enum(:my_select) unless block_given?

    while i < arr.length
      temp_arr.push(arr[i]) if yield arr[i]
      i += 1
    end
    temp_arr
  end

  def my_all?(param = nil)
    arr = to_a
    if block_given?
      arr.my_each { |element| return false unless yield element }
    elsif param.nil?
      arr.my_each { |element| return false if element.nil? or element == false }
    elsif param.is_a? Class
      arr.my_each { |element| return false unless [element.class, element.class.superclass].include?(param) }
    elsif param.instance_of?(Regexp)
      arr.my_each { |element| return false unless element =~ param }
    else
      arr.my_each { |element| return false if element != param }
    end
    true
  end

  def my_any?(param = nil)
    arr = to_a
    if block_given?
      arr.my_each { |element| return true if yield element }
    elsif param.nil?
      arr.my_each { |element| return true if element }
    elsif param.is_a? Class
      arr.my_each { |element| return true if [element.class, element.class.superclass].include?(param) }
    elsif param.instance_of?(Regexp)
      arr.my_each { |element| return true if element =~ param }
    else
      arr.my_each { |element| return true if element == param }
    end
    false
  end

  def my_none?(param = nil, &block)
    arr = to_a
    if block_given?
      !arr.my_any?(&block)
    else
      !arr.my_any?(param)
    end
  end

  def my_count(param = nil)
    i = 0
    arr = to_a
    counter = 0
    my_each { |number| counter += 1 if number == param } unless param.nil?
    return counter unless param.nil?
    return arr.length unless block_given?

    counter = 0
    while i < arr.length
      counter += 1 if yield arr[i]
      i += 1
    end
    counter
  end

  def my_map(proc = nil)
    i = 0
    arr = to_a
    temp_arr = []
    return to_enum(:my_map) unless block_given? or !proc.nil?

    if proc.nil?
      while i < arr.length
        temp_arr.push(yield arr[i])
        i += 1
      end
    else
      while i < arr.length
        temp_arr.push(proc.call(arr[i]))
        i += 1
      end
    end
    temp_arr
  end

  def my_inject(*param)
    i = 0
    arr = to_a
    acumulator = first if param.empty?
    acumulator = param[0] if param[0].instance_of?(Integer)
    unless param.empty?
      if param[0].instance_of?(Integer) and param[1].instance_of?(Symbol)
        acumulator = param[0].to_i
        while i < arr.length
          acumulator = param[1].to_proc.call(acumulator, arr[i])
          i += 1
        end
      elsif param[0].instance_of?(Symbol)
        acumulator = first
        while i < arr.length
          acumulator = param[0].to_proc.call(acumulator, arr[i])
          i += 1
        end
      end
      return acumulator
    end
    while i < arr.length
      acumulator = yield acumulator, arr[i] if i.positive?
      i += 1
    end
    acumulator
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength, Metrics/MethodLength

def multiply_els(arr)
  arr.my_inject(1, :*)
end
