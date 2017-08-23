# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

companies = JSON.parse(File.read('./app/assets/companies.json'))
people = JSON.parse(File.read('./app/assets/people.json'))

puts "haha, JSON file loaded...."

Company.destroy_all
Person.destroy_all
Food.destroy_all

puts "creating companies......."
companies.each do |c|
  Company.create!(c)
end


puts "creating foods....."
total_food = Array.new

people.each do |p|
  total_food.push(p["favouriteFood"]).flatten!.uniq!
end

puts "#{total_food}"
# ["orange", "apple", "banana", "strawberry", "cucumber", "beetroot", "carrot", "celery"]

total_food.first(4).each do |f|
  Food.create name: f, category: 'fruits'
end

total_food.last(4).each do |f|
  Food.create name: f, category: 'vegetables'
end

puts "creating people, creating people-foods associations...."

people.each do |p|
  person = Person.create!(p.except('favouriteFood', 'tags', 'company_id'))
  person.company_index = p["company_id"]
  person.save!
  p['favouriteFood'].each do |f|
    person.foods << Food.find_by(name:f)
  end
end


puts "hehe"
