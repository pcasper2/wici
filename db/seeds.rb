require 'faker'

#create standard users
10.times do
  user = User.new(
    name:        Faker::Name.name,
    email:       Faker::Internet.email,
    password:    Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

#create premium users
3.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10),
    role:       "premium"
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

#create admin user
admin = User.new(
  name:       "Admin User",
  email:      "admin@example.com",
  password:   "helloworld",
  role:       "admin"
  )
admin.skip_confirmation!
admin.save!


#create wicis
100.times do
  wici = Wici.create!(
    user:      users.sample,
    title:     Faker::Lorem.sentence,
    body:      Faker::Lorem.paragraph
    )
end
wicis = Wici.all

puts "Seeding finished!"
puts "#{User.count} users created"
puts "#{Wici.count} wicis created"
puts "Good job!"