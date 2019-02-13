module ItemsHelper

  def item_quantity(item, cart)
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item.id)
    @cart_item.quantity
  end

  def item_is_shipped(cart_id, item_id)
    CartItem.find_by(cart_id: cart_id, item_id: item_id).shipped
  end
end