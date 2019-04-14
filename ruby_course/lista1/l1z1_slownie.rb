def slownie(n)
  j = 0 # mowi o liczbie zer
  rank = 0 # rank mówi czy jestem w setkach, tysiącach, milionach, ...
  word = ""
  oneness = ['', ' jeden', ' dwa', ' trzy', ' cztery', 'pięć', ' sześć', ' siedem', ' osiem', ' dziewięć' ]
  teen =  ['dziesięć', ' jedenaście', ' dwanaście', ' trzynaście', 'czternaście', ' piętnaście', ' szesnaście',
    ' siedemnaście', ' osiemnaście', ' dziewiętnaście']
  ty = ['', ' dziesięć', ' dwadzieścia', ' trzydzieści', ' czterdzieści', ' pięćdziesiąt', 'sześćdziesiąt',
    'siedemdziesiąt', ' osiemdziesiąt', ' dziewięćdziesiąt']
  hundred =  ['', ' sto', 'dwieście', ' trzysta', ' czterysta', 'pięćset', 'sześćset', ' siedemset', ' osiemset',
    ' dziewięćset']
  rank_tab = ['', ' tys.']
  if n == 0
    word = 'zero'
  end
  while n > 0 do
    last_num = n % 10 # dzięki modulo zyskuję ostatnią cyfrę z liczby n
    n /= 10
    if j == 0 && (n % 100 != 0 || last_num != 0) #doczepiamy w odpowiednim miejscu
      word = rank_tab[rank] + word
    end
    if j == 0 && n % 10 != 1 # jeśli przedostatnia jest jedynką to przechodzimy do -naście
      word = oneness[last_num] + word
    end
    if j == 0 && n % 10 == 1
      word = teen[last_num] + word
      n /= 10
      j += 2
      next
    end
    if j == 1
      word = ty[last_num] + word
    end
    if j == 2
      word = hundred[last_num] + word
      j = -1
      rank += 1;
    end
    j += 1
  end
  return word
end

puts(slownie(100))
puts(slownie(9999))
puts(slownie(1000))
puts(slownie(12))
