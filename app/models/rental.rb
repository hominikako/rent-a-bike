class Rental < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :bike
  
  before_save :validate
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  
  
  def validate
    errors.add(:error, "Start date cannot be bigger or equal than end_date") if self.end_date <= self.start_date
    errors.add(:error, "Start date has to be today onwards") if self.start_date < Time.now.to_date
    errors.add(:error, "Price has to be a positive value") if self.price.nil?  or self.price < 1
    byebug
    rentals = Rental.where(:bike_id => self.bike_id)
    dates_taken = false
    rentals.each do |r|
      byebug
      if (self.start_date >= r.start_date and self.start_date <= r.end_date )
        dates_taken = true
        break
      elsif (self.end_date >= r.start_date and self.end_date <= r.end_date)
        dates_taken = true
        break
      end
    end
    errors.add(:error, "Bike already booked for this dates") if dates_taken==true
    return false if self.errors.size > 0
    return true
  end
end
