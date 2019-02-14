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

michaels_items = [['Rare 1940 antique gramophone', 5299.99, 'Rare 1940 antique gramophone, great condition', true, 1, 2, "app/assets/images/items_images/gramophone.png", "gramophone.png"],
  ['SIEMENS Washing Machine', 599.99, '2015 SIEMENS Washing machine, works great!', true, 2, 2, "app/assets/images/items_images/washer.png", "washer.png"],
  ['Multicolor Abstract Painting', 199.99, 'Painted by one of the most renowned artist in modern time', false, 3, 1, "app/assets/images/items_images/painting_1.png", "painting_1.png"],
  ['Assorted Color Plastic Toys', 14.99, 'Great for kids ages 3+', true, 4, 1, "app/assets/images/items_images/toys_1.png", "toys_1.png"],
  ['Books', 99.99, "Zero to One, Ego is the Enemy, The Obstacle is the Way, Exponential Organization, The Story of Innovation, Value Proposition Design, The Startup Owner's Manual, and The Corporate Startup" , false, 5, 2, "app/assets/images/items_images/books_1.png", "books_1.png"],
  ['Black Sony Alpha DSLR Camra', 1299.99, 'Rated as one of the best DSLR camra out there.', true, 6, 1, "app/assets/images/items_images/camra.png", "camra.png"],
  ['2016 Black and Blue Mustang', 250, 'Great condition, low mileage', true, 7, 2, "app/assets/images/items_images/mustang.png", "mustang.png"]]

michaels_items.each do |name, price, description, in_stock, category_id, condition, image, filename|
  michael.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
  if image 
    michael.items.last.image.attach(io: File.open(image), filename: filename)
  end
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

