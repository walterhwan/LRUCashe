require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      resize! if @count >= num_buckets
      bucket = self[key]
      bucket << key

      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr_buckets = Array.new(num_buckets * 2) { Array.new }

    @store.each do |bucket|
      bucket.each do |num|
        new_arr_buckets[num % new_arr_buckets.length] << num
      end
    end
    @store = new_arr_buckets
  end
end


if __FILE__ == $PROGRAM_NAME
  set = HashSet.new
  set.insert(50)
  set.insert("howdy")
  set.insert([])
  set.insert({:a => 3, :b => 4})

  p set
end
