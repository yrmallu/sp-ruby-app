# frozen_string_literal: true

require 'set'

# contains a hash which stores page paths(k) and a tally of unique visits(v)
class UniqueViewsCounter
  attr_reader :unique_path_visits

  def initialize
    @unique_path_visits = {}
  end

  def add(line)
    if unique_path_visits.key?(line.path)
      unique_path_visits[line.path] << line.ip
    else
      unique_path_visits[line.path] = Set.new([line.ip])
    end
  end

  def results
    # Print out the number of unique visits in descending order
    unique_path_visits.sort_by { |_path, ips| [-ips.count] }.map { |path, ips| "#{path} #{ips.count} unique views" }
  end
end
