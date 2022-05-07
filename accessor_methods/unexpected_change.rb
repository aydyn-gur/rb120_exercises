class Person
  def name=(full_name)
    arr = full_name.split(' ')
    @first_name = arr.first 
    @last_name = arr.last
  end
  
  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
