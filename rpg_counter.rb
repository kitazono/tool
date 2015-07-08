# RPGのステップ数をカウントする

def main(directory_name = ARGV[0])

  Dir.open(directory_name) {|dir|
    Dir.chdir(directory_name)

    puts "Program      Real  Comnt  Total"
    puts "-------------------------------"

    step_sum = 0
    comment_sum = 0
    total_sum = 0

    dir.each {|file|
      next if file == "." || file == ".."
      open(file) {|f|
        step = 0
        comment = 0
        total = 0
        while line = f.gets
          total += 1
          if line[6] == "*"
            comment += 1
          else
            step += 1
          end
        end
        printf "%-10s %6d %6d %6d\n", file.sub(".txt",""), step, comment, total
        step_sum += step
        comment_sum += comment
        total_sum += total
      }
    }
    puts "-------------------------------"
    printf "%-10s %6d %6d %6d\n", "Total", step_sum, comment_sum, total_sum
  }

end

main()
