class Movie < ActiveRecord::Base
  
  def self.ratings
    self.pluck(:rating).uniq
  end
  
   
  
end
