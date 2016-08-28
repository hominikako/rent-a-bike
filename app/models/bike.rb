class Bike < ActiveRecord::Base
    
    has_many :rentals
    has_many :users, through: :rentals
  
    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true
    validates :status, presence: true
    
    before_save :validate
    validates_numericality_of :price, :greater_than => 0
    
    # check if the search value matches either the name or description of the bike
    def self.search(search_for)
        Bike.where("name like ? or description like ?", "%#{search_for}%","%#{search_for}%")
    end
    
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
