# CLの呼び出しているHULFT集配信のFILE_IDを抽出する

def search_pattern(file, r)
  open(file) {|f|
    while line = f.gets
      if m = line.match(r)
        yield(m)
      end
    end
  }
end

def main(directory_name = ARGV[0])

  Dir.open(directory_name) {|dir|
    Dir.chdir(directory_name)

    dir.each {|file|
      next if file == "." || file == ".."
      search_pattern(file, /CALL\s+PGM\(BSHULFT\)\s+PARM\('(.)'\s+(.+)\s+'(.+)'/) {|m|
        file_id = m[2]
        search_pattern(file, /CHGVAR\s+VAR\(#{file_id}\)\s+VALUE\('(.+)'\)/) {|m|
          puts "#{file.sub(".txt", "")} #{m[1].strip}"
        }
      }
    }
  }

end

main()
