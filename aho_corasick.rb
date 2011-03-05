class AhoCorasickTree
  def initialize(*strs)
    @root = Node.new(nil)
    @currentnode = @root
    strs.each{|str|insert str}
    reflesh
  end

  def reflesh
    queue = Array.new
    # BFS to first depth
    @root.each do |c1,n1|
      n1.failure = @root
      n1.each{|c2,n2|queue.push [c2,n2]}
    end
    # BFS
    while !queue.empty? do
      char, node = queue.shift
      node.each{|c,n|queue.push [c,n]}
      node.failure = node.parent.failure.find char
      node.matches.concat node.failure.matches
    end
  end

  def insert(str)
    node = @root
    str.each_char do |c|
      node = node.get(c) || node.insert(c)
    end
    node.matches.concat [str]
  end

  def apply(char)
    (@currentnode = @currentnode.find char).matches
  end

  class Node
    def initialize(parent)
      @children = Hash.new
      @parent = parent
      @failure = nil
      @matches = Array.new
    end
    attr_accessor :failure, :matches;
    attr_reader :parent;
    def insert(char)
      @children[char.to_sym] = Node.new(self)
    end
    def each(&block)
      if block
        @children.each &block
      else
        Enumrator.new(self)
      end
    end
    def get(char)
      @children[char.to_sym]
    end

    def find(char)
      @children[char.to_sym] || (failure ? failure.find(char) : self)
    end
  end
end
