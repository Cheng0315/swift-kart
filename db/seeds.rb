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
Category.create(name: 'Musical Instruments')
Category.create(name: 'Office')
Category.create(name: 'Pet Supplies')
Category.create(name: 'Sporting Goods')
Category.create(name: 'Tools')
Category.create(name: 'Video Games')

michael = User.create(first_name: 'Michael', last_name: 'Smith', seller: true, email: 'michaelsmith@gmail.com', password: 'a')
amanda = User.create(first_name: 'Amanda', last_name: 'Williams', seller: true, email: 'amandawilliam@yahoo.com', password: 'b')
jenny = User.create(first_name: 'Jenny', last_name: 'Miller', seller: true, email: 'jennymiller@gmail.com', password: 'c')
joseph = User.create(first_name: 'Joseph', last_name: 'Peterson', seller: true, email: 'jpeterson@outlook.com', password: 'd')

michaels_items = [['Rare 1940 Antique Gramophone', 5299.99, 'Rare 1940 antique gramophone, great condition.', true, 1, 2, "app/assets/images/items_images/gramophone.png", "gramophone.png"],
  ['SIEMENS Washing Machine', 599.99, '2015 SIEMENS Washing machine, works great!', true, 2, 2, "app/assets/images/items_images/washer.png", "washer.png"],
  ['Multicolor Abstract Painting', 199.99, 'Painted by one of the most renowned artist in modern time.', false, 3, 1, "app/assets/images/items_images/painting_1.png", "painting_1.png"],
  ['Assorted Color Plastic Toys', 14.99, 'Great for kids ages 3+', true, 4, 1, "app/assets/images/items_images/toys_1.png", "toys_1.png"],
  ['Books', 99.99, "Zero to One, Ego is the Enemy, The Obstacle is the Way, Exponential Organization, The Story of Innovation, Value Proposition Design, The Startup Owner's Manual, and The Corporate Startup" , false, 5, 2, "app/assets/images/items_images/books_1.png", "books_1.png"],
  ['Black Sony Alpha DSLR Camra', 1299.99, 'Rated as one of the best DSLR camra out there.', true, 6, 1, "app/assets/images/items_images/camra.png", "camra.png"],
  ['2016 Black and Blue Mustang', 25000, 'Great condition, low mileage.', true, 7, 2, "app/assets/images/items_images/mustang.png", "mustang.png"]]

michaels_items.each do |name, price, description, in_stock, category_id, condition, image, filename|
  michael.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
  michael.items.last.image.attach(io: File.open(image), filename: filename)
end



amandas_items = [['iPhone X', 999.99, "Apple's latest iphone - iPhone X.", true, 8, 1, "app/assets/images/items_images/iphone_3.png", "iphone_3.png"],
  ['Black Sleeveless Dress', 79.99, 'Light weight, irressistible dress.', true, 9, 1, "app/assets/images/items_images/black_dress.png", "black_dress.png"],
  ['27-inch Silver iMac w/ Magic keyboard.', 1399.99, "3.5GHz quad-core 7th-generation Intel Core i5 processor, Retina 5K 5120-by-2880 P3 display", true, 10, 1, "app/assets/images/items_images/imac.png", "imac.png"],
  ['CocoOil', 9.99, 'Oil for the body.', true, 11, 1, "app/assets/images/items_images/coco_oil.png", "coco_oil.png"],
  ['Gardening Tools', 24.99, 'Great tools for gardening.', true, 12, 2, "app/assets/images/items_images/gardening_tools.png", "gardening_tools.png"],
  ['Silver-colored Earrings with Gemstones', 499.99, 'Gorgeous, irresistable earrings.', true, 13, 1, "app/assets/images/items_images/earrings_1.png", "earrings_1.png"],
  ['Harry Potter and The Chamber of Secrets', 5.99, '2002 Fantasy/Mystery Movie', true, 14, 2, "app/assets/images/items_images/harry_potter.png", "harry_potter.png"]]

amandas_items.each do |name, price, description, in_stock, category_id, condition, image, filename |
  amanda.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
  amanda.items.last.image.attach(io: File.open(image), filename: filename)
end



jennys_items = [['Fender White Electric Guitar', 599.99, 'Great sound, like new.', true, 15, 2, "app/assets/images/items_images/guitar_1.png", "guitar_1.png"],
  ['Student Desk and Chair', 69.99, 'Great Desk and comfortable chair, like new.', true, 16, 2, "app/assets/images/items_images/desk_chair.png", "desk_chair.png"],
  ['Dog Chow', 19.99, 'Healthy and nutritious foods for your dogs.', true, 17, 1, "app/assets/images/items_images/dog_chow.png", "dog_chow.png"],
  ['Schutt Football Helmet', 49.99, 'Great helmet, like new', true, 18, 2, "app/assets/images/items_images/football_helmet.png", "football_helmet.png"],
  ['Garage and Backyard Tools', 9.99, 'Cleared out the garage and came across these tools. Hopefully someone will put these to good uses.', false, 19, 2, "app/assets/images/items_images/tools_1.png", "tools_1.png"],
  ['Game', 345, 'Game', true, 20, 1, "app/assets/images/items_images/staple.png", "staple.png"]]

jennys_items.each do |name, price, description, in_stock, category_id, condition, image, filename|
  jenny.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
  jenny.items.last.image.attach(io: File.open(image), filename: filename)
end



josephs_items = [['Red and Brown Floral Dress', 49.99, 'lightweight, comfortable dress', true, 9, 1, "app/assets/images/items_images/red_dress.png", "red_dress.png"],
  ["Women's Assorted Clothes", 79.99, 'Available in all sizes', true, 9, 1, "app/assets/images/items_images/clothing.png", "clothing.png"],
  ['Classic Long Sleeve White Sweater', 24.99, 'Classic Design Long Sleeve Sweater', true, 9, 1, "app/assets/images/items_images/white_sweater.png", "white_sweater.png"],
  ['Wilson Evolution Basketball', 44.99, 'The preferred ball of many high school and college athletes, the Wilson® Evolution® Game Basketball.', true, 18, 1, "app/assets/images/items_images/basketball.png", "basketball.png"],
  ['Pro Preferred Custom Glove', 449.99, 'Pro Preferred custom gloves are worn by Pro players and can be personalized with thousands of options', true, 18, 1, "app/assets/images/items_images/baseball_mitt.png", "baseball_mitt.png"]]

josephs_items.each do |name, price, description, in_stock, category_id, condition, image, filename|
  joseph.items.create(name: name, price: price, description: description, in_stock: in_stock, category_id: category_id, condition: condition)
  joseph.items.last.image.attach(io: File.open(image), filename: filename)
end

reviews = [[1, 8, 4, 'Amazing phone and great features and long lasting battery!'], [1, 17, 4, 'My dog loves it!!'], [1, 21, 5, 'Bought this dress for my wife. She loves it!'], [2, 3, 5, 'Love this painting!!!'], [2, 15, 4, 'Love it!'], [2, 25, 4, 'Great Mitt!!!'], [3, 4, 5, 'My kids love these toys!'], [3, 11, 4, 'One of the better oil out there for the body.'], [3, 6, 5, 'Love this camra!!!'], [4, 10, 4, 'Great product'], [4, 16, 4, 'A perfect desk for my college daughter.'], [4, 18, 4, 'Bought this for my boy and he loves it'], [4, 6, 4, 'Great camra!']]

reviews.each do |review|
  Review.create(user_id: review[0], item_id: review[1], rating: review[2], comment: review[3])
end