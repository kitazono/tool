require "date"
require "./workday.rb"

include BankHoliday

def calender(year = Date.today.year, month = Date.today.month)
  first = Date.new(year, month, 1)             # 指定した月の1日
  last = Date.new(year, month, -1)             # 指定した月の月末
  start = first.wday == 0 ? 6 : first.wday - 1 # 指定した月が開始する曜日の前に入る余白の数

  puts first.strftime("%Y年%m月").center(21)
  puts " 月 火 水 木 金 土 日"
  buf = "   " * start
  next_date = first
  while next_date <= last
    if next_date === Date.today
      buf << sprintf(" \e[7m%2d\e[0m", next_date.day)      
    elsif holiday?(next_date)
      buf << sprintf(" \e[4m%2d\e[0m", next_date.day)
    else
      buf << sprintf("%3d", next_date.day)
    end

    if next_date.wday == 0
      puts buf
      buf = ""
    end
    next_date = next_date.next
  end
  puts buf
  puts
  puts (WorkDate.new(year, month, 1) - 1).eigo(4).strftime("%m/%d 1日約定自振戻り")
  puts (Date.new(year, month + 1, 1) - 15).strftime("%m/%d 1日約定請求確定")
  puts last.strftime("%m/%d 月末")

end

if ARGV[0]
  calender(ARGV[0].to_i, ARGV[1].to_i)
else
  calender
end