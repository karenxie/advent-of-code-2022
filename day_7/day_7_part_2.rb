class Directory
  
  @dirs = Hash.new { |h, k| h[k] = Directory.new(k) }

  class << self
    include Enumerable

    def [](name) 
      @dirs[name]
    end

    def each(&block)
      @dirs.values.each(&block)
    end
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @content = []
  end

  def size
    @content.sum(&:size)
  end

  def add_content(item)
    @content << item
  end

  def expand_path(path) 
    File.expand_path(path, name)
  end
end

FileObject = Struct.new(:name, :size)

input_file = ARGV[0]
input = File.read(input_file)
input_lines = input.split("\n").map(&:strip)
current_directory = Directory['/']

input_lines.each do |line|
  if line.start_with?("$")
    tokens = line.split(" ")
    command = tokens[1]
    if command == "cd"
      directory = tokens[2]
      current_directory = Directory[current_directory.expand_path(directory)]
    end
  else
    filesize_or_dir, name = line.split(" ")
    if filesize_or_dir == "dir"
      current_directory.add_content(Directory[current_directory.expand_path(name)])
    else
      current_directory.add_content(FileObject.new(name, filesize_or_dir.to_i))
    end
  end
end

TOTAL_DISK_SPACE = 70000000
REQUIRED_FOR_UPDATE = 30000000
needed_to_clear = REQUIRED_FOR_UPDATE - (TOTAL_DISK_SPACE - Directory['/'].size)
puts Directory.select { |dir| dir.size >= needed_to_clear}.min_by(&:size).size