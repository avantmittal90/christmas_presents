class Wishlist
  attr_reader :name, :size, :clatters, :weight

  @objects = []

  # -------------------------
  # Section for class methods
  # -------------------------
  class << self
    attr_accessor :objects

    def add(_name, _size, _clatters, _weight)
      new(_name, _size, _clatters, _weight).add
      objects
    end

    def import(_objects)
      _objects.each do |obj|
        add(obj[:name], obj[:size], obj[:clatters], obj[:weight])
      end
    end

    def clear
      @objects = []
    end
  end
  
  # ----------------------------
  # Section for instance methods
  # ----------------------------
  def initialize(_name, _size, _clatters, _weight)
    @name     = _name
    @size     = _size.downcase
    @clatters = _clatters.downcase
    @weight   = _weight.downcase
  end

  def add
    (self.class.objects << { name: name, size: size, clatters: clatters, weight: weight }) if valid?
  end

  def valid?
    valid =   ["small", "medium", "large"].include?(size)
    valid ||= ["no", "a bit", "yes"].include?(clatters)
    valid ||= ["light", "medium", "heavy"].include?(size)
    valid
  end
end
