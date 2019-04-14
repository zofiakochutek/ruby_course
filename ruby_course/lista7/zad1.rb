require "drb"
require "dbm"

class LogSerwer
  def initialize(name)
    @serwer = DBM.open(name)
  end
  def save(prg_id, msg)
    time = Time.new.to_s
    @serwer[time] = [prg_id, msg]
  end
  def report(since, to, prg_id, re)
    @serwer.each do |time, msg|
      if time > since
        while time < to do
          if prg_id == msg[0] && time =~ re
            return html  # skąd ???
          end
        end
      end
  end
end
