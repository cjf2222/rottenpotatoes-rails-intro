class Movie < ActiveRecord::Base
  def self.movies(sort_field)
    self.order(sort_field)
end
