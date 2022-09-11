# frozen_string_literal: true

# contains a hash which stores page paths(k) and a tally of visits(v)
class PageVisitsCounter
  attr_reader :page_counts

  def initialize
    @page_counts = {}
  end

  def add(line)
    page_counts[line.path] ||= 0
    page_counts[line.path] += 1
  end

  def results
    # print out pages in descending order showing counts and path
    page_counts.sort_by { |_page, count| [-count] }.map { |page, count| "#{page} #{count} visits" }
  end
end
