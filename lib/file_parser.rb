# frozen_string_literal: true

require_relative 'line'
require_relative 'page_visits_counter'
require_relative 'unique_views_counter'
require_relative 'custom_exceptions'

class FileParser
  attr_reader :file, :page_visits, :uniq_views

  def initialize(file, page_visits = PageVisitsCounter.new, uniq_views = UniqueViewsCounter.new)
    @file = file
    @page_visits = page_visits
    @uniq_views = uniq_views
  end

  def print_result
    [page_visits.results, uniq_views.results].flatten
  end

  def parse
    check_file_exists?
    # use File.foreach to read file line by line. File.read would read the whole file
    # into memory at once
    File.foreach(file) do |line|
      line_obj = Line.new(line)
      page_visits.add(line_obj)
      uniq_views.add(line_obj)
    end
  end

  private

  def check_file_exists?
    return if File.exist?(file)

    raise FileNotFound, "File doesn't exist"
  end
end
