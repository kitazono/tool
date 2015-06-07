require "date"
require "./bank_holiday.rb"

include BankHoliday

class WorkDate < Date

  def eigo(n)
    if n > 0
      sign = 1
    elsif n == 0
      n = 1
      sign = 1
    else
      sign = -1
    end
    date = self
    n.abs.times do
      begin 
        date += 1 * sign
      end while holiday?(date)
    end
    date
  end

end
