# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
   Article.create(title: "title #{i}", body: "body #{i}", visited: "#{i}")
end

# User.create(id: "1",email:"mizuno@gmail.com" ,encrypted_password: "aaaaaa" )