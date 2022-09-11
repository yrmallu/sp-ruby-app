# frozen_string_literal: true

require_relative './lib/file_parser'

file_parser = FileParser.new((ARGV[0]))
file_parser.parse
puts file_parser.print_result
