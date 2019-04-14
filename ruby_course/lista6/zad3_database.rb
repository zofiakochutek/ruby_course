require "dbm"

class Notebook
  def initialize(notebook_name)
    @notebook = DBM.open(notebook_name)
  end
  def add_friend(friend, email, telefon_nr, nick)
    email_reg = /[a-z]+@([a-z]+\.)+[a-z]+/
    telefon_reg = /[0-9]{9}/
    if not email =~ email_reg
      puts("niepoprawny email")
    end
    if not telefon_nr =~ telefon_reg
      puts("nieprawidłowy numer telefonu")
    end
    if email =~ email_reg && telefon_nr =~ telefon_reg
      data_tab = [email, telefon_nr, nick]
      @notebook[friend] = data_tab
    end
  end
  def browse_notebook
    @notebook.each { |friend, data| puts "#{friend} => #{data}"}
  end
  def search_in_notebook(friend)
    puts @notebook[friend]
  end
  def delete_friend(friend)
      if @notebook[friend] != nil
        @notebook.delete(friend)
      end
  end
end
