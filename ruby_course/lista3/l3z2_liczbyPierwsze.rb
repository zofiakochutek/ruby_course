include Math

def pierwsza(n) # sito Eratostenesa
  arr = Array.new(n+1)
  range = Math.sqrt(n)
  i = 2
  while i <= range
    if arr[i] == nil
      b = (i*i)
      b.step(n, i){|j| arr[j] = 0} # ustawiam kolejne wielokrotnosci liczb
                                  # na zero
    end
    i += 1
  end
  arr2 = []
  for i in 2...arr.length
    if arr[i] != 0
      arr2.push(i)
    end
  end
  return arr2
end

print(pierwsza(100))

def prime(n)
  if n < 2
    return false
  end
  range = Math.sqrt(n)
  for i in 2..range
    if n % i == 0
      return false
    end
  end
  return true
end

def doskonale(n) # metodą Euklidesa
  sum = 1
  pow = 1
  arr = []
  while sum < n
    pow = pow * 2
    sum += pow
    if prime(sum)
      perfect = sum * pow
      arr.push(perfect)
    end
  end
  return arr
end

puts()
print(doskonale(1000))
