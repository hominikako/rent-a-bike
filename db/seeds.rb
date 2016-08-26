# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.email = 'javi@admin.com'
user.name = 'Javi'
user.last_name = 'Ferrer'
user.role = 1
user.password = '123123'
user.password_confirmation = '123123'
user.save!
