module ItemsHelper

  #find quantity if items in cart
  def item_quantity(item, cart)
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item.id)
    @cart_item.quantity
  end

  #find status of an item
  def item_status(item, cart)
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item.id)

    if @cart_item.shipped 
      "<span class='shipped-items'>Shipped!</span>".html_safe 
    else
      "<span class='unshipped-items'>Preparing for shipping.</span>".html_safe 
    end
  end

  #image helper method
  def item_image(item_id)
    @item = Item.find(item_id)

    if @item.image.attached?
      image_tag(@item.image, style:"width:100%")
    else
      image_tag('items_images/default_image', style:"width:100%")
    end
  end

  #small image helper method
  def small_image(item_id)
    @item = Item.find(item_id)

    if @item.image.attached?
      image_tag(@item.image, style:"width:90px")
    else
      image_tag('items_images/default_image', style:"width:90px")
    end
  end

  def item_condition(item)
    if item.condition == 1
      "<p class='condition-new text-center' >New</p>".html_safe
    else
      "<p class='condition-used text-center' >Used</p>".html_safe
    end
  end

  def item_availability(item)
    if item.in_stock 
      "<p class='instock' >In stock</p>".html_safe
    else 
      "<p class='out-of-stock' >Out of stock</p>".html_safe
    end
  end

  def buyer_name(id)
    @user = User.find(id)
    @user.first_name + " " + @user.last_name
  end

  #check if the user's carts are empty
  def my_carts_are_empty(carts)
    carts.count == 1 && !carts[0].checkout
  end

  #add check mark to 'add to cart' button
  def add_to_cart_w_check_mark(item_id)
    if current_user
      @item_arr = current_cart.items.select {|item| item.id == item_id}
      add_check_mark(@item_arr)
    else
      @item_arr = guest_cart.select {|id| id == item_id}
      add_check_mark(@item_arr)
    end
  end

  #Add check mark if item is already in the user's cart
  def add_check_mark(item_arr)
    if item_arr.empty?
      "Add to cart"
    else
      "<i class='fas fa-check'></i> Add to cart".html_safe
    end
  end

  def reviews_link(item, reviews)
    if reviews.blank?
      "<a href='/items/#{item.id}/reviews/new' onClick='window.location.reload()'>Be the first to review this item</a>"
    else
      "<a href='#reviews'>#{reviews.count} Customer reviews</a>"
    end
  end

  def item_overall_rating(item)
    avg_rating = item.reviews.average(:rating).to_f

    return '' if avg_rating == 0

    display_stars_rating(avg_rating)
  end

  def display_stars_rating(rating)
    stars_str = ""

    round_down_avg = rating.floor
    mid = rating - round_down_avg
    hollow_star_rating = 5 - round_down_avg - 1 

    round_down_avg.times do 
      stars_str += "<i class='fa fa-star fa-fw'></i>"
    end

    
    if mid >= 0 && mid < 0.25 && rating != 5
      stars_str += "<i class='far fa-star fa-fw'></i>"
    elsif mid >= 0.25 && mid < 0.75
      stars_str += "<i class='fas fa-star-half-alt'></i>"
    elsif mid >= 0.75 && mid <= 1
      stars_str += "<i class='fa fa-star fa-fw'></i>"
    end

    hollow_star_rating.times do 
      stars_str += "<i class='far fa-star fa-fw'></i>"
    end

    stars_str + '&nbsp&nbsp'
  end

  


end