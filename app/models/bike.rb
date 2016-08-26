class Bike < ActiveRecord::Base
    
    has_many :rentals
    has_many :users, through: :rentals
  
    # Type of status for a bike
    def self.what_status_is
        [:Available, :Reparing]
    end
   
    def self.what_category_is
        ["Mountain Bike", "Hybrid Bike", "BMX Bike", "Tandem Bike"]
    end
    
    # Returns a symbol with the status of the bike
    def status_sym
        return nil if status.nil?
        Bike.what_status_is[status]
    end
    
    def category_str
        return nil if status.nil?
        Bike.what_category_is[category]
    end
end
