class Movie < ActiveRecord::Base
  def self.movies(filters, sort_field)
    self.where({:rating => filters}).order(sort_field)
  end
  
  def ratings
    self.pluck(:rating).uniq
  end
  
end
