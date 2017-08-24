# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

companies = JSON.parse(File.read('./app/assets/companies.json'))
people = JSON.parse(File.read('./app/assets/people.json'))
# import JSON files and parse them as hash

puts "JSON file loaded...."

# make sure no duplicate data
Company.destroy_all
Person.destroy_all
Food.destroy_all


puts "creating companies......."
companies.each do |c|
  Company.create!(c)
end

puts "creating foods....."
# create an empty array to store all the favouriteFood arrays
total_food = Array.new

# loop through people.json, push the favouriteFood values into the food array and then flatten it
# also remove duplicate items
people.each do |p|
  total_food.push(p["favouriteFood"]).flatten!.uniq!
end

puts "#{total_food}"
# ["orange", "apple", "banana", "strawberry", "cucumber", "beetroot", "carrot", "celery"]

# split foods into fruits and vegetables as their categories
total_food.first(4).each do |f|
  Food.create name: f, category: 'fruits'
end

total_food.last(4).each do |f|
  Food.create name: f, category: 'vegetables'
end


puts "creating people, creating people-foods associations...."

people.each do |p|
  person = Person.create!(p.except('favouriteFood', 'tags', 'company_id', 'friends'))

  # setting the company_id in json file as company_index, as company_index will be the reference
  person.company_index = p["company_id"]
  person.save!
  p['favouriteFood'].each do |f|
    person.foods << Food.find_by(name:f)
  end
end

puts "creating people-friends associations...."
# after create all the people, loop through people.json again to build people-friends associations
people.each do |p|
  person = Person.find_by(index:p['index'])
  p['friends'].each do |f|
    person.friends << Person.find_by(index:f["index"])
  end
end

puts "hehe"
