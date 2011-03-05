require 'aho_corasick'

terms = %w! int long prints printf fuck public typo static zzero 2ch twitter typedef fuga >> piyo const dame nauxa acnoid cida kdis hge kxill fguck type def func hii ci cauxteh noh ondhia noashdxhZZ DEFINE if strucn!
tree = AhoCorasickTree.new(*terms)

str = ARGF.read
str.each_char do |char|
  match = tree.apply char
end

puts "----------"
str.scan(Regexp.union(*terms))#.each{|s|puts s}
