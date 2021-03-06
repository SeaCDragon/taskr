# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'taskrdev', email: 'seacdragon@gmail.com', password: 'foobar', password_confirmation: 'foobar', admin: true, activated: true, activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)

50.times do
	title = Faker::Lorem.sentence(word_count: 3)
	users.each {|user| user.projects.create!(title: title)}
end

user = User.find(1)
project = user.projects.first
content = Faker::Lorem.sentence(word_count: 10)

10.times do
	project.tasks.create!(content: content)
end
