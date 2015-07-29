# CLのステップ数をカウントする

def main(directory_name = ARGV[0])

  Dir.open(directory_name) {|dir|
    Dir.chdir(directory_name)

    puts "Program     Real Comnt Empty Total"
    puts "-----------------------------------"

    step_sum = 0
    comment_sum = 0
    space_sum = 0
    total_sum = 0

    dir.each {|file|
      next if file == "." || file == ".."
      open(file) {|f|
        step = 0
        comment = 0
        space = 0
        total = 0
        while line = f.gets
          total += 1
          if line =~ /^\s*$/
            space += 1
          elsif line =~ /^(\s*\/\*(.*?)\*\/\s*)?+$/
            comment += 1
          else
            step += 1
          end
        end
        printf "%-10s %5d %5d %5d %5d\n", file.sub(".txt",""), step, comment, space ,total
        step_sum += step
        comment_sum += comment
        space_sum += space
        total_sum += total
      }
    }
    puts "-----------------------------------"
    printf "%-10s %5d %5d %5d %5d\n", "Total", step_sum, comment_sum, space_sum, total_sum
  }

end

main()
