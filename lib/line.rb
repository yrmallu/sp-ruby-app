# frozen_string_literal: true

class Line
  attr_reader :path, :ip

  def initialize(line)
    split_line = line.split
    @path = split_line[0]
    @ip = split_line[1]
  end
end
