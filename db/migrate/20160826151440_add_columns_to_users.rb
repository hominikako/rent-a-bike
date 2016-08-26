class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, :default => 0
    add_column :users, :name, :string
    add_column :users, :last_name, :string
  end
end
