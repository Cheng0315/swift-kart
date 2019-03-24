const pluralize = (quantity) => {
  if (quantity === 1) {
    return '1 items'
  } else {
    return `${quantity} items`
  }
}

$(function(){
  let gPrice1 = 0; let gPrice11 = 0; let gQuantity1 = 0; let gQuantity11 = 0; 
  let gPrice2 = 0; let gPrice12 = 0; let gQuantity2 = 0; let gQuantity12 = 0; 
  let gPrice3 = 0; let gPrice13 = 0; let gQuantity3 = 0; let gQuantity13 = 0; 
  let gPrice4 = 0; let gPrice14 = 0; let gQuantity4 = 0; let gQuantity14 = 0; 
  let gPrice5 = 0; let gPrice15 = 0; let gQuantity5 = 0; let gQuantity15 = 0; 
  let gPrice6 = 0; let gPrice16 = 0; let gQuantity6 = 0; let gQuantity16 = 0; 
  let gPrice7 = 0; let gPrice17 = 0; let gQuantity7 = 0; let gQuantity17 = 0; 
  let gPrice8 = 0; let gPrice18 = 0; let gQuantity8 = 0; let gQuantity18 = 0; 
  let gPrice9 = 0; let gPrice19 = 0; let gQuantity9 = 0; let gQuantity19 = 0; 
  let gPrice10 = 0; let gPrice20 = 0; let gQuantity10 = 0; let gQuantity20 = 0; 
  
  let gTotalQuantity = parseInt($("#total-num-of-items").text());
  

  $(".select-quantity").change(function() {
    const idx = parseFloat($(this).attr('data-idx'));
    const itemPrice = parseFloat($(this).attr('data-price'));
    const totalPrice = parseFloat($(this).attr('data-total-price'));
    const quantity = parseFloat($('#' + $(this).attr('id')).val());
    const quantityPrice = itemPrice * quantity - itemPrice;
    
    if (quantity == 1) {
      eval('gPrice' + (idx + 1) + '= 0;');
      eval('gQuantity' + (idx + 1) + '= 0;');
    } else {
      eval('gPrice' + (idx + 1) + `= ${quantityPrice}`);
      eval('gQuantity' + (idx + 1) + `= ${quantity - 1}`);
    }

    const totalPriceSums = totalPrice + gPrice1 + gPrice2 + gPrice3 + gPrice4 + gPrice5 + gPrice6 + gPrice7 + gPrice8 + gPrice9 + gPrice10 + gPrice11 + gPrice12 + gPrice13 + gPrice14 + gPrice15 + gPrice16 + gPrice17 + gPrice18 + gPrice19 + gPrice20;
    const totalQuantitySums = gTotalQuantity + gQuantity1 + gQuantity2 + gQuantity3 + gQuantity4 + gQuantity5 + gQuantity6 + gQuantity7 + gQuantity8 + gQuantity9 + gQuantity10 + gQuantity11 + gQuantity12 + gQuantity13 + gQuantity14 + gQuantity15 + gQuantity16 + gQuantity17 + gQuantity18 + gQuantity19 + gQuantity20;
    
    $("#quantity_price").text("$" + totalPriceSums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'))
    $(".num-of-items").text(totalQuantitySums)
    $("#items-total").text(pluralize(totalQuantitySums))
  })
})