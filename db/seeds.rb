require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |i|
  Package.create!(
    name: Faker::Commerce.product_name,
    start_price_cents: 1000,
    minimum_price_cents: 9000,
    start_time: Time.now,
    end_time: i.days.from_now)
end
