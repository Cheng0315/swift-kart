module ItemsHelper

  def item_quantity(item, cart)
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item.id)
    @cart_item.quantity
  end

  def item_is_shipped(cart_id, item_id)
    CartItem.find_by(cart_id: cart_id, item_id: item_id).shipped
  end

  def item_status(item, cart)
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item.id)
    @cart_item.shipped ? "Shipped! Your item is on its way!" : "Preparing to ship."
  end

  def item_image(item_id)
    @item = Item.find(item_id)

    if @item.image.attached?
      image_tag(@item.image, style:"width:100%")
    else
      image_tag('items_images/default_image', style:"width:100%")
    end
  end

  def item_condition(item)
    if item.condition == 1
      "New"
    else
      "Used"
    end
  end

  def item_availability(item)
    item.in_stock ? "In Stock" : "Out of stock"
  end


end