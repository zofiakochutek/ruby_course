load "zad3_database.rb"

$n1 = Notebook.new("my_notebook")

def manage_notebook
  puts("--------------------------------------")
  puts("Wciśnij odpowiednią cyfrę aby : ")
  puts("[1] dodać znajomego")
  puts("[2] przejrzeć notatnik")
  puts("[3] usunąć znajomego")
  puts("[4] wyszukać dane znajomego")
  decision = gets.chomp
  case decision
  when "1"
    puts("Podaj imię znajomego")
    friend = gets.chomp
    puts("Podaj email znajomego")
    email = gets.chomp
    puts("Podaj numer telefonu znajomego")
    telefon = gets.chomp
    puts("Podaj nick znajomego")
    nick = gets.chomp
    $n1.add_friend(friend, email, telefon, nick)
  when "2"
    puts("Znajomi zapisani w notatniku: ")
    $n1.browse_notebook()
  when "3"
    puts("Podaj znajomego do usunięcia")
    friend = gets.chomp()
    $n1.delete_friend(friend)
  when "4"
    puts("Podaj znajomego do wyszukania")
    friend = gets.chomp()
    $n1.search_in_notebook(friend)
  end
  manage_notebook()
end


manage_notebook()
