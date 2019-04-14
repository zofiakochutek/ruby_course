require "dbm"

$calendar = DBM.open("new_calendar")

  def add_meeting_or_task(time, meeting)
    $calendar[time] = meeting
  end
  def browse_calendar
    $calendar.each { |time, task| puts "#{time} => #{task}"}
  end
  def search_in_calendar(time_to_search)
    puts $calendar[time_to_search]
  end
  def set_reminder(time)
  end
  def delete_task(time_to_search)
      $calendar.each_key { |time|
        if time == time_to_search
          $calendar.delete(time)
        else
          puts "W tym czasie nie ma zaplanowanych spotkań."
        end
      }
  end
