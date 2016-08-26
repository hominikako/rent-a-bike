class Bike < ActiveRecord::Base
    
    # Type of status for a bike
    def self.what_status_is
        [:Available, :Reparing]
    end
    
    # Returns a symbol with the status of the bike
    def status_sym
        return nil if status.nil?
        Bike.what_status_is[status]
    end
end
