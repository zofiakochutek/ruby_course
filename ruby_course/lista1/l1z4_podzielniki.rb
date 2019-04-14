
def podzielniki(n)
  tab = []
  position = 0
  for i in 2..n/2 #zakladam ze n nie jest liczba pierwsza
    if n % i == 0
      tab[position] = i
      position += 1
      while n % i == 0
        n /= i
      end
    end
  end
  return tab
end


print(podzielniki(16))
puts
print(podzielniki(1025))
puts
print(podzielniki(100))
puts
print(podzielniki(7))
