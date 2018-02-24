class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0
    self.each_with_index do |el, i|
      hash += el.hash ^ i
    end

    hash
  end
end

class String
  def hash
    hash = 0

    self.chars.each_with_index do |chr, idx|
      hash += chr.ord ^ idx
    end

    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0

    self.each_pair do |key, val|
      hash += key.hash ^ val.hash
    end

    hash
  end
end
