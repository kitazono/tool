# RPGのプログラム中で使用されている項目名を探索

class Line

  attr_reader :line, :factor1, :operation, :factor2, :result

  def initialize(line)
    @line = line
    @factor1 = line[17..26].to_s.delete("\n").strip
    @operation = line[27..31].to_s.strip
    @factor2 = line[32..41].to_s.strip
    @result = line[42..47].to_s.strip
  end
end

def main(directory = ARGV[0], item = ARGV[1])

  done_list = []
  item_list = []

  item_list << item

  while item = item_list.shift
    item_list = search_item(directory, item)
    item_list.uniq!
    done_list << item
    item_list = item_list - done_list

    p item_list
  end

  # Dir.open(directory_name) {|dir|
  #   Dir.chdir(directory_name)

  #   dir.each {|file|
  #     next if file == "." || file == ".."
  #     open(file) {|f|
  #       while line = f.gets
  #         if line[5] == "C" && line[6] != "*"
  #           l = Line.new(line)
  #           if l.factor1 == item_name
  #             puts "#{f.path} #{f.lineno} #{l.line}"
  #             item_list << l.factor2
  #           end
  #         end
  #       end
  #     }
  #   }
  # }  

end

def search_item(directory, item)
  item_list = []
  Dir.open(directory) {|dir|
    Dir.chdir(directory)
    dir.each {|file|
      next if file == "." || file == ".."
      open(file) {|f|
        while line = f.gets
          if line[5] == "C" && line[6] != "*"
            l = Line.new(line)
            if l.factor1 == item
              puts "#{f.path} #{f.lineno} #{l.line}"
              item_list << l.factor2
            end
          end
        end
      }
    }
  }
  item_list
end

main()


