def main(directory_name = ARGV[0])
  Dir.open(directory_name) {|dir|
    Dir.chdir(directory_name)

    dir.each {|file|
      next if file == "." || file == ".."
      open(file) {|f|
        while line = f.gets
          p line
        end
      }
    }
  }
end

main