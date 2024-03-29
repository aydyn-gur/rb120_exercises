# class MinilangError < StandardError; end
# class EmptyStackError < MinilangError; end

# class Minilang
#   attr_accessor :register, :stack
  
#   def initialize(string)
#     @program = string
#     @stack = []
#     @register = 0
#   end
  
#   def eval
#     @program.split.each do |word|
#       case word
#       when 'PUSH'         then @stack.push(register)
#       when 'SUB'          then self.register -= clean_pop
#       when 'MULT'         then self.register *= clean_pop
#       when 'DIV'          then self.register /= clean_pop
#       when 'ADD'          then self.register += clean_pop
#       when 'MOD'          then self.register %= clean_pop
#       when 'POP'          then self.register = clean_pop
#       when 'PRINT'        then puts register
#       when /\A[-+]?\d+\z/ then self.register = word.to_i
#       else
#         puts "Invalid token: #{word}"
#         break
#       end
#     rescue MinilangError => error
#       puts error.message
#       break
#     end
#   end
  
#   def clean_pop
#     raise EmptyStackError, "Empty Stack!" if stack.empty?
#     stack.pop
#   end
# end

require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval
    @stack = []
    @register = 0
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
