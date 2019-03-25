Rails App with JavaScript Frontend Spec

Project Specs:

[x] Must have a Rails Backend and new requirements implemented through JavaScript.

[x] Makes use of ES6 features as much as possible(e.g Arrow functions, Let & Const, Constructor       Functions)

[x] Must translate the JSON responses into Javascript Model Objects using either ES6 class or         constructor syntax. 

[x] Must render at least one index page (index resource - 'list of things') via JavaScript and an     Active Model Serialization JSON Backend.

[x] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.

[x] Your Rails application must reveal at least one `has-many` relationship through JSON that is then rendered to the page.

[x] Must use your Rails application to render a form for creating a resource that is submitted [x]dynamically through JavaScript.

[x] At least one of the JS Model Objects must have a method on the prototype.

Project Repo Specs:

Read Me file contains:

[x] Application Description

[x] Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)

[x] Contributors guide (e.g. file an issue, file an issue with a pull request, etc)

[x] Licensing statement at the bottom (e.g. This project has been licensed under the MIT open source license.)

Repo General

[x] You have a large number of small Git commits

[x] Your commit messages are meaningful

[x] You made the changes in a commit that relate to the commit message

[x] You don't include changes in a commit that aren't related to the commit message


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