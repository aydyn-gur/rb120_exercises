class Cat
  @@total_num = 0
  
  def initialize
    @@total_num += 1
  end
  
  def self.total
    puts @@total_num
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
