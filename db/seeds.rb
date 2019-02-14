# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create(name: 'Antiques')
Category.create(name: 'Appliances')
Category.create(name: 'Art')
Category.create(name: 'Baby')
Category.create(name: 'Books')
Category.create(name: 'Camras')
Category.create(name: 'Cars')
Category.create(name: 'Cell Phones')
Category.create(name: 'Clothing & Shoes')
Category.create(name: 'Computer')
Category.create(name: 'Health')
Category.create(name: 'Home & Garden')
Category.create(name: 'Jewelry')
Category.create(name: 'Movies')
Category.create(name: 'Musical Instrument')
Category.create(name: 'Office')
Category.create(name: 'Pet Supplies')
Category.create(name: 'Sporting Goods')
Category.create(name: 'Tools')
Category.create(name: 'Video Games')

michael = User.create(first_name: 'Michael', last_name: 'Smith', seller: true, email: 'a@a.com', password: 'a')
amanda = User.create(first_name: 'Amanda', last_name: 'Williams', seller: true, email: 'b@b.com', password: 'b')
jenny = User.create(first_name: 'Jenny', last_name: 'Miller', seller: true, email: 'c@c.com', password: 'c')

michaels_items = [['Rare Japanese Antique', 250, 'Rare 1940 antique gramophone', true, 1, 1],
  ['Rare Japanese Antique', 456, 'Rare Japanese Antique Army Sake Bottle', true, 2, 2],
  ['Rare Japanese Antique', 68, 'Rare Japanese Antique Army Sake Bottle', true, 3, 1],
  ['Rare Japanese Antique', 876, 'Rare Japanese Antique Army Sake Bottle', true, 4, 2],
  ['Rare Japanese Antique', 23424, 'Rare Japanese Antique Army Sake Bottle', true, 5, 1],
  ['Rare Japanese Antique', 345, 'Rare Japanese Antique Army Sake Bottle', true, 6, 1],
  ['Rare Japanese Antique', 250, 'Rare Japanese Antique Army Sake Bottle', true, 7, 2]]

michaels_items.each do |name, price, description, in_stock, category_id, condition|
  michael.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
end


amandas_items = [['Rare Japanese Antique', 456456, 'Rare Japanese Antique Army Sake Bottle', true, 8, 1],
  ['Rare Japanese Antique', 654, 'Rare Japanese Antique Army Sake Bottle', true, 9, 2],
  ['Rare Japanese Antique', 87686, 'Rare Japanese Antique Army Sake Bottle', true, 10, 1],
  ['Rare Japanese Antique', 890, 'Rare Japanese Antique Army Sake Bottle', true, 11, 2],
  ['Rare Japanese Antique', 2342, 'Rare Japanese Antique Army Sake Bottle', true, 12, 1],
  ['Rare Japanese Antique', 42320, 'Rare Japanese Antique Army Sake Bottle', true, 13, 2],
  ['Rare Japanese Antique', 26456, 'Rare Japanese Antique Army Sake Bottle', true, 14, 1]]

amandas_items.each do |name, price, description, in_stock, category_id, condition|
  amanda.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
end



jennys_items = [['Rare Japanese Antique', 57, 'Rare Japanese Antique Army Sake Bottle', true, 15],
  ['Rare Japanese Antique', 456, 'Rare Japanese Antique Army Sake Bottle', true, 16, 2],
  ['Rare Japanese Antique', 3453, 'Rare Japanese Antique Army Sake Bottle', true, 17, 1],
  ['Rare Japanese Antique', 502, 'Rare Japanese Antique Army Sake Bottle', true, 18, 2],
  ['Rare Japanese Antique', 8797, 'Rare Japanese Antique Army Sake Bottle', true, 19, 2],
  ['Rare Japanese Antique', 345, 'Rare Japanese Antique Army Sake Bottle', true, 20, 1]]

jennys_items.each do |name, price, description, in_stock, category_id, condition|
  jenny.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
end

