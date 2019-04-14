def statystyka_slow()
	file = File.open('romeo-i-julia.txt', "r")
	arr = file.readlines

	slowa = {}
	ilość_słów = 0
	arr.each do |linia|
	    linia.gsub("\n", '').split(' ').each do |slowo|
	    	if not ['.', ',', '/'].include? slowo 
	    		if slowo.length() > 3
				    slowa[slowo] = 0 unless slowa[slowo]
				    slowa[slowo]+= 1
				    ilość_słów += 1
				end
			end
		end
	end
	slowa.each_value {|ilosc| ilosc = (ilosc / ilość_słów) * 100}
	slowa.each_key {|slowo| slowa[slowo] = ((slowa[slowo]*100/ilość_słów.to_f).round(5)) }
	slowa = slowa.sort_by {|slowo, ilosc| ilosc}
	puts slowa
	print "\n"
	#puts ilość_słów
end

statystyka_slow()

# w komediach znajdują się slowa typu: wróżka, FUJARKA,
# duchy, krew, serce, księżyc, lula, słońce, dowcip,
# szczęście, widma, piękna, nudzić, 
# łotr, hultaj, pieniądze, szaleństwo, wstyd, głupi
# kij, kupiec, diabeł, dowcip, błazeństwo, żart 

# w tragediach: miłość, ratujcie, krew, serce, Bóg,
# łotr, łzy, miecz, 
# śmierć, grób, wieść, łzy, niebo, smutny, dowcip


# powtarzają się: łotr, krew, miłość, dowcip
# w komedii występowanie postaci fantastycznych