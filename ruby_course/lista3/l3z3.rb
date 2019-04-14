def rozklad(n) # na czynniki pierwsze
  tab = []
  for i in 2..n
    counter = 0
    if n % i == 0
      while n % i == 0 do
        n /= i
        counter += 1
      end
      tab2 = [i,counter]
      tab.push(tab2)
    end
  end
  return tab
end

print(rozklad(756))
puts()
print(rozklad(17))
puts()

def rozklad2_sum(n) #na wszystkie mozliwe dzielniki właściwe + sumuje je
  tab = []
  sum = 0
  for i in 1...n
    if n % i == 0
      tab.push(i)
    end
  end
  for i in 0...tab.length
    sum += tab[i]
  end
  return sum
end

def zaprzyjaznione(n) #para różnych liczb naturalnych, takich że suma dzielników właściwych
                      #(mniejszych od tej liczby) każdej z tych liczb równa się drugiej
  tab = []
  tab_res = []
  for i in 2..n
    sum = rozklad2_sum(i)
    tab[i] = sum
  end
  for i in 1..n
    for j in (i+1)..n
      if i == tab[j] && j == tab[i]
        t = [i,j]
        tab_res.push(t)
      end
    end
  end
  return tab_res
end

print(zaprzyjaznione(3000))
