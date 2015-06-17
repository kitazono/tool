
# RPGのプログラム中で使用されている命令を頻出度順に出力

class Line
  def initialize(line)
    @line = line
  end

  def specificationType
    @line[5]
  end

  def isComment
    @line[6] == "*"
  end

  def factor1
    @line[17..26].to_s.delete("\n").strip
  end

  def operation
    @line[27..31].to_s.strip

  end

  def factor2
    @line[32..41].to_s.strip

  end

  def result
    @line[42..47].to_s.strip

  end

  def to_s
    @line
  end
end


def main(filename = ARGV[0])

  input_file = open(filename + ".txt")

  count = Hash.new(0)

  while line = input_file.gets
    line = Line.new(line)
    o = Operation.new(line.operation,line.factor1,line.factor2,line.result)

    if line.specificationType == "C" && !(line.isComment)
      count[o.name] += 1
    end 
  end

  input_file.close

  sort_command = count.sort_by{|key,val| -val}

  rank = 1

  sort_command.each do |key, val| 
    puts "#{rank}. #{key} #{val}" 
    rank += 1
  end

end

main()
