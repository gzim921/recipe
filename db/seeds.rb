# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ingredient = Ingredient.create(name: 'Brocoly')
ingredient = Ingredient.create(name: 'Bean')
ingredient = Ingredient.create(name: 'Milk')
ingredient = Ingredient.create(name: 'Water')
ingredient = Ingredient.create(name: 'Oil')
ingredient = Ingredient.create(name: 'Roast Chicken')
ingredient = Ingredient.create(name: 'Pineapple')
ingredient = Ingredient.create(name: 'Tomatoes')
ingredient = Ingredient.create(name: 'Meat')
ingredient = Ingredient.create(name: 'Salami')

recipe = Recipe.new(name: 'Brocoly')
recipe.directions = 'Wash Brocoly, cut it, and add salt'
recipe.ingredients
recipe.save