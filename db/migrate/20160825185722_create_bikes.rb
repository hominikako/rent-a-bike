class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :category
      t.integer :status

      t.timestamps null: false
    end
  end
end
