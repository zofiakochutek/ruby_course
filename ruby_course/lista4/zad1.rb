class Expression
  def initialize(a, b)
    @a = a
    @b = b
  end
end

class Constant
  def initialize(number)
    @number = number
  end
  def execute(mem)
    return @number
  end
  def to_s
    return @number.to_s
  end
end

#$set_vars = {}

class Variable
  def initialize(name)
    @name = name
  end
  def to_s
    return @name
  end
  def execute(mem)
    if mem.has_key?(@name)
      return mem[@name]
    else
      return @name
    end
  end
end

class Addition < Expression
  def execute(mem)
      return @a.execute(mem) + @b.execute(mem)
  end
  def to_s
    return @a.to_s + " + " + @b.to_s + " = "
  end
  def simplify(mem)
    if @a.execute(mem) == 0 then return @b.execute(mem) end
    if @b.execute(mem) == 0 then return @a.execute(mem) end
  end
end

class Mult < Expression
  def execute(mem)
      return @a.execute(mem) * @b.execute(mem)
  end
  def to_s
    return @a.to_s + " * " + @b.to_s + " = "
  end
  def simplify
    if @a == 1 then return @b end
    if @b == 1 then return @a end
  end
  def simplify2
    if @a == 1/@b or @b == 1/@a then return 1 end
  end
end

class Subt < Expression
  def execute(mem)
      return @a.execute(mem) - @b.execute(mem)
  end
  def to_s
    return @a.to_s + " - " + @b.to_s + " = "
  end
  def simplify
    if @b == 0 then return @a end
  end
end

class Division < Expression
  def execute(mem)
    if @b.execute(mem) != 0
      return @a.execute(mem) / @b.execute(mem)
    else
      return "Error: Division by zero"
    end
  end
  def to_s()
    return @a.to_s + " / " + @b.to_s + " = "
  end
  def simplify(mem)
    if @b.execute(mem) == 1 then return @a.execute(mem) end
  end
end


mem = {}
a = Constant.new(0)
b = Constant.new(1)
e1 = Addition.new(a, b)
print("e1: " + e1.to_s)
puts(e1.execute(mem))
print("e1 simplified: " + e1.simplify(mem).to_s)




class Comp
  def initialize(a, b)
    @a = a
    @b = b
  end
  def execute(mem)
    return @a.execute(mem) != @b.execute(mem)
  end
  def to_s
    return @a + " != " + @b
  end
end


class Subs
  def initialize(var_name, number)
    @name = var_name
    @number = number
  end
  def execute(mem)
    mem[@name] = @number.execute(mem)
    return mem
  end
  def to_s
    return @name + " = " + @number.to_s
  end
end

class If
  def initialize(condition, if_true_then, if_false_then)
    @condition = condition
    @if_true_then = if_true_then
    @if_false_then = if_false_then
  end
  def execute()
    if @condition
      return @if_true_then
    else
      return @if_false_then
    end
  end
  def to_s()
    return "if " + @condition + " then "+ @if_true_then + " else " + @if_false_then
  end
end


class While
  def initialize(condition, to_do)
    @condition = condition
    @do = to_do
  end
  def execute(mem)
    if @condition.execute(mem)
      @do.execute(mem)
    else
      return mem
    end
  end
  def to_s
    return "while " + condition + " " + @do
  end
end


class Block
  def initialize(tab)
    @tab = tab
  end
  def execute(tab, mem)
    if tab.nil?
      return mem
    else
      execute(tab.delete_at(0), tab[0].execute(mem))
    end
  end
end

=begin
puts(1.class != String)
a = Constant.new(1).execute()
puts a.class
b = Variable.new("b").execute()
e1 = Addition.new(a, b)
print("e1 = " + e1.to_s())
puts(e1.execute())

e2 = Mult.new(a, b)
print("e2 = " + e2.to_s())
puts(e2.execute())
puts("e2 simplified: "+  e2.simplify().to_s())
s = "if else"
puts(s.partition(' ').first)
=end


def silnia(n)
  silnia = 1
  while n != 0 do
    silnia *= n
    n -= 1
  end
  return silnia
end

def silnia_rek(n, silnia)
  if n == 0
    return silnia
  else
    silnia_rek(n-1, silnia*n)
  end
end

#print(silnia(4))
#print(silnia_rek(3, 1))
=begin
tab2 = []
tab2[0] = Subs.new("silnia", Mult.new("silnia", "n"))
tab2[1] = Subs.new("n", Subt.new("n", Constant.new(1)))

p1 = Block.new(tab2)

tab = []
tab[0] = Subs.new("silnia", Constant.new(1))
tab[1] = Subs.new("n", Constant.new(3))
tab[2] = While.new(Comp.new("n", Constant.new(0)), p1)

#silnia = Variable.new("silnia")
#n = Variable.new("n")
#mem = {}
p2 = Block.new(tab)
print(p2.execute(tab, mem))
=end
