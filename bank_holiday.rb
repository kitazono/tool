require "date"

module BankHoliday

  WEEK1 = 1..7
  WEEK2 = 8..14
  WEEK3 = 15..21
  WEEK4 = 22..28
  SUN,MON,TUE,WED,THU,FRU,SAT = (0..6).to_a
  INF = 1.0/0.0

  # 祝日 : 2014年1月1日以降で有効
  DATA = [
    ["元日",2014..INF,1,1],
    ["銀行の休日",2014..INF,1,2],
    ["銀行の休日",2014..INF,1,3],
    ["成人の日",2014..INF,1,WEEK2,MON],
    ["建国記念の日",2014..INF,2,11],
    ["春分の日",2014..2099,3,proc{|y|Integer(20.8431+0.242194*(y-1980))-Integer((y-1980)/4.0)}],
    ["昭和の日",2014..INF,4,29],
    ["憲法記念日",2014..INF,5,3],
    ["みどりの日",2014..INF,5,4],
    ["こどもの日",2014..INF,5,5],
    ["海の日",2014..INF,7,WEEK3,MON],
    ["山の日",2016..INF,8,11],
    ["敬老の日",2014..INF,9,WEEK3,MON],
    ["秋分の日",2014..2099,9,proc{|y|Integer(23.2488+0.242194*(y-1980))-Integer((y-1980)/4.0)}],
    ["体育の日",2014..INF,10,WEEK2,MON],
    ["文化の日",2014..INF,11,3],
    ["勤労感謝の日",2014..INF,11,23],
    ["天皇誕生日",2014..INF,12,23],
    ["銀行の休日",2014..INF,12,31]
  ]

  module_function

  def holiday_date(year,data)
    name,year_range,mon,day,wday = data
    if year_range === year
      case day
      when Integer
        Date.new(year,mon,day)
      when Range
        wday0 = Date.new(year,mon,day.first).wday
        Date.new(year,mon,day.first+(wday-wday0+7)%7)
      when Proc
        Date.new(year,mon,day.call(year))
      end
    end
  end

  def create_table(year)
    holiday_table = {}
    holidays = []
    # list holidays
    DATA.each do |data|
      if day = holiday_date(year,data)
        holiday_table[day] = data[0]
        holidays << day if data[0] != "銀行の休日"
      end
    end
    # 振替休日
    holidays.each do |day|
      if day.wday == SUN
        day += 1 while holiday_table[day]
        holiday_table[day] = "振替休日"
      end
    end
    # 国民の休日
    holidays.each do |day|
      if holiday_table[day+2] and !holiday_table[day+1] and day.wday != SAT
        holiday_table[day+1] = "国民の休日"
      end
    end
    holiday_table
  end

  def name(date)
    y = date.year
    create_table(y)[date]
  end

  def holiday?(date)
    date.wday == SAT or date.wday == SUN or name(date)
  end

  def list_year(year)
    create_table(year).sort_by{|x| x[0]}
  end

  def print_year(year)
    list_year(year).each do |y|
      puts "#{y[0].strftime('%Y-%m-%d %a')} #{y[1]}"
    end
  end
end

# command line
if __FILE__ == $0
  BankHoliday.print_year(ARGV[0].to_i)
end