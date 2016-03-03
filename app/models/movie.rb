class Movie < ActiveRecord::Base
  
  def self.ratings
    self.pluck(:rating).uniq
  end
  
  def self.movies(filters, sort_field)
    self.where({:rating => filters}).order(sort_field)
  end
  
end
