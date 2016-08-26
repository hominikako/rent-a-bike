class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.date :start_date
      t.date :end_date
      t.float :price
      t.belongs_to :user, index: true 
      t.belongs_to :bike, index: true 

      t.timestamps null: false
    end
  end
end
