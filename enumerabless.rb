a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,]


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
end

a.my_each{|number|}

a.my_each_with_index{|number, index| p index.to_s + " " + "is" + " " + number.to_s}