class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # self[num] << num
    bucket = self[num]
    bucket << num
    # p "num #{num}"
    # p "bucket #{bucket.object_id}"
    # p "self[num] #{self[num].object_id}"
  end

  def remove(num)
    bucket = self[num]
    bucket.delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % 20] #bucket
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      resize! if @count >= num_buckets
      bucket = self[num]
      bucket << num

      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr_buckets = Array.new(num_buckets * 2) { Array.new }

    @store.flatten.each do |num|
      new_arr_buckets[num % new_arr_buckets.length] << num
    end
    @store = new_arr_buckets
  end
end

# [ [1,2,3],[4,5,6] ]
#
# [1,2,3,4,5,6]


if __FILE__ == $PROGRAM_NAME
  set = IntSet.new
  set.insert(1)
  p set.include?(1)
end
