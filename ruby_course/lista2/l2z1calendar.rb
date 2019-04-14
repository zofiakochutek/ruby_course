$calendar = Hash.new
$calendar[["10.10", "12.00"]] = "meeting with Anne"

def add_content(day, hour, content)
  for k in $calendar.keys
    if k[0] == day && k[1] == hour
      puts("Error: Chosen date is already reserved.")
    else
      $calendar[[day,hour]] = content
    end
  end
end

def add_content_from_user()
  puts("Input day:")
  day = gets.chomp
  puts("Input hour:")
  hour = gets.chomp
  puts("Input content")
  content = gets.chomp
  add_content(day, hour, content)
  main()
end

def write_content(calendar)
  $calendar = calendar.sort.to_h
  print($calendar)
  print("\n")
  main()
end


def main()
    puts("-----------------------------------------------")
    puts("This is your calendar. What do you want to do?")
    puts("To add content click 1.")
    puts("To check your meetings click 2.")
    decision = gets.chomp
    if decision == "1"
      add_content_from_user()
    elsif decision == "2"
      write_content($calendar)
    else
      puts("Incorrect data")
    end
    main()
end

main()
