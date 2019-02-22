Specs:

 [x] Using Ruby on Rails for the project

 [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) user has many carts

 [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) cart belongs to user

 [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) cart has many items through cart_item

 [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) item.quantity

 [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) AR validations in user model

 [x] Include a class level ActiveRecord scope method (such as .where and .order) .where in item model

 [x] Include a nested form writing to an associated model using a custom attribute writer (You must include a nested index or show route) users/1/item/1

 [x] Include signup (how e.g. Devise) 

 [x] Include login (how e.g. Devise)

 [x] Include logout (how e.g. Devise)

 [x] Include third party signup/login (how e.g. Devise/OmniAuth) Facebook

 [x] Include nested resource show or index (URL e.g. users/2/recipes) users/1/item/1

 [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) users/1/item/new

 [x] Include form display of validation errors (form URL e.g. /recipes/new) yup

Confirm:

 [x] The application is pretty DRY
 [x] Limited logic in controllers
 [x] Views use helper methods if appropriate
 [x] Views use partials if appropriate