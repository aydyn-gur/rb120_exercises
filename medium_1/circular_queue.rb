class CircularQueue
  def initialize(num)
    @queue = Array.new(num)
    @maximum_length = num
    @count = 0
    @oldest = 0
  end
  
  def enqueue(number)
    @oldest = increment(@oldest) unless @queue[@count].nil?
    @queue[@count] = number
    @count = increment(@count)
  end
  
  def dequeue
    value = @queue[@oldest]
    @queue[@oldest] = nil
    @oldest = increment(@oldest) unless value.nil?
    value
  end
  
  private 
  
  def increment(position)
    (position + 1) % @maximum_length
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)

puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
