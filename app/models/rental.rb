class Rental < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :bike
  
  before_save :validate
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  
  
  def validate
    errors.add(:start_date, "start_date cant be bigger than end_date") if self.end_date < self.start_date
    errors.add(:price, "price cant be 0") if self.price.nil?  or self.price == 0
    return false if self.errors.size > 0
    return true
  end
end
