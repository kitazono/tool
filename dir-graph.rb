require "ruby-graphviz"

# ディレクトリの階層構造を描画

$gv = GraphViz.new( :G, :type => "graph", :rankdir => "LR" )
$gv.node[:shape] = "box"

def dirs(dir_name)  
  Dir.chdir(dir_name)
  Dir.glob("*") do |object|
    path = "#{dir_name}/#{object}"
    $gv.add_edge($gv.add_node("#{dir_name.split("/")[-1]}"), $gv.add_node("#{object}"))
    dirs(path) if File.directory?(path)
  end
end

dirs(ARGV[0])
Dir.chdir(ARGV[0])
$gv.output( :png => "output.png" )