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
    description: Faker::Lorem.paragraph,
    start_price_cents: 100,
    minimum_price_cents: 30,
    start_time: Time.now + (i-1),
    end_time: i.days.from_now)
end
