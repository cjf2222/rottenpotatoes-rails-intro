class Movie < ActiveRecord::Base
 
  
  def self.ratings
    self.pluck(:rating).uniq
  end
  
   def self.movies(sort_field)
    self.order(sort_field)
  end
  
end
