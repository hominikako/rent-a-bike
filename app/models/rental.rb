class Rental < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :bike
  
  before_save :validate
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  
  # validations before adding a new rental
  def validate
    errors.add(:start_date, "cannot be bigger or equal than end_date") if self.end_date <= self.start_date
    errors.add(:start_date, "has to be today or onwards") if self.start_date < Time.now.to_date
    errors.add(:price, "has to be a positive value") if self.price.nil?  or self.price < 1
    # Retreaves all the bookings for this bike
    rentals = Rental.where(:bike_id => self.bike_id).reject {|r| (r.start_date < Date.today.to_date)  } 
    dates_taken = false
    rentals.each do |r|
      # If the starting date is in the middle of any other booking for this bike
      if (self.start_date >= r.start_date and self.start_date <= r.end_date )
        dates_taken = true
        break
      # If the ending date is in the middle of any other booking for this bike
      elsif (self.end_date >= r.start_date and self.end_date <= r.end_date)
        dates_taken = true
        break
      # If the starting and ending date are wrapping another booking dates for this bike
      elsif (self.start_date <= r.start_date and self.end_date >= r.end_date)
        dates_taken = true
        break
      end
    end
    errors.add(:Bike, "already booked for these dates") if dates_taken==true
    return false if self.errors.size > 0
    return true
  end
end
