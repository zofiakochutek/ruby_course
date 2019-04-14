load "zad1_database.rb"


def ask_user()
  puts("--------------------------------------")
  puts("Wciśnij odpowiednią cyfrę aby : ")
  puts("[1] dodać wydarzenie")
  puts("[2] przejrzeć kalendarz")
  puts("[3] usunąć wydarzenie z kalendarza")
  puts("[4] wyszukać wydarzenie w kalendarzu")
  decision = gets.chomp()
  case decision
  when "1"
    puts("Podaj datę")
    date = gets.chomp()
    puts("Podaj wydarzenie")
    task = gets.chomp()
    add_meeting_or_task(date, task)
  when "2"
    puts("Wydarzenia zapisane w kalendarzu")
    browse_calendar()
  when "3"
    puts("Podaj datę do usunięcia")
    date = gets.chomp()
    delete_task(date)
  when "4"
    puts("Podaj datę do wyszukania")
    date = gets.chomp()
    search_in_calendar(date)
  end
  ask_user()
end

ask_user()
