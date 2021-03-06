module CartsHelper

  #helper for updating quantity and price in cart checkout page
  def id_of_select_tag(idx)
    "my_select_#{idx}"
  end

  #helper for updating quantity and price in cart checkout page
  def on_change_funct(idx, price, cart)
    @all_items_price = total_price(cart)
    "total_price(#{idx}, #{price}, #{@all_items_price})"
  end

  #sums all items price including quantity
  def add_all_quantity_prices(str_prices)
    sums = 0

    str_prices.split(",").each do |price| 
      sums += price.to_i 
    end

    sums
  end

  #sums all items price excluding quantity
  def total_price(cart)
    cart.sum {|item| item.price} 
  end


  
end