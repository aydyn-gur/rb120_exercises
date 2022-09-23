class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def current_state
    puts "The switch is currently #{switch}."
  end
  
  private 
  
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
machine.start
machine.current_state
machine.stop
machine.current_state
