# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Category.create(name: 'Fitness')
Category.create(name: 'Health')
Category.create(name: 'Entertainment')
Category.create(name: 'Education')
Category.create(name: 'Sport')

Subcategory.create(name: 'Men Gyms', category_id: 1)
Subcategory.create(name: 'Ladies Gym', category_id: 1)
Subcategory.create(name: 'Yoga', category_id: 1)
Subcategory.create(name: 'Hospitals', category_id: 2)
Subcategory.create(name: 'Pharmacies', category_id: 2)
Subcategory.create(name: 'Opticals', category_id: 2)
Subcategory.create(name: 'Events', category_id: 3)
Subcategory.create(name: 'Cinemas', category_id: 3)
Subcategory.create(name: 'Sea Activities', category_id: 3)
Subcategory.create(name: 'Schools', category_id: 4)
Subcategory.create(name: 'Universities', category_id: 4)
Subcategory.create(name: 'Training programs', category_id: 4)
Subcategory.create(name: 'Football', category_id: 5)
Subcategory.create(name: 'Basketball', category_id: 5)
Subcategory.create(name: 'Cricket', category_id: 5)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
