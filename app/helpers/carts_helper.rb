module CartsHelper

  def id_of_select_tag(idx)
    "my_select_#{idx}"
  end

  def on_change_funct(idx, price, cart)
    @all_items_price = total_price(cart)
    "total_price_#{idx+1}(#{idx}, #{price}, #{@all_items_price})"
  end

  def add_all_quantity_prices(str_prices)
    sums = 0

    str_prices.split(",").each do |price| 
      sums += price.to_i 
    end

    sums
  end

  def total_price(cart)
    cart.sum {|item| item.price} 
  end
end