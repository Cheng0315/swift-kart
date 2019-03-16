// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .



  let price1 = 0;
  let price2 = 0;
  let price3 = 0;
  let price4 = 0;
  let price5 = 0;
  let price6 = 0;
  let price7 = 0;
  let price8 = 0;
  let price9 = 0;
  let price10 = 0;
  
  function total_price(idx, item_price, all_items_price) {
    let quantity = document.getElementById(`my_select_${idx}`).value;
    let quantity_price = item_price * quantity - item_price;

    if (quantity == 1) {
      eval('price' + (idx + 1) + '= 0');
    } else {
      eval('price' + (idx + 1) + `= ${quantity_price}`);
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

$(document).ready(function(){

  $('#stars li').on('mouseover', function(){
    var onStar = parseInt($(this).data('value'), 10); 
   
    $(this).parent().children('li.star').each(function(e){
      if (e < onStar) {
        $(this).addClass('hover');
      }
      else {
        $(this).removeClass('hover');
      }
    });
  }).on('mouseout', function(){
    $(this).parent().children('li.star').each(function(e){
      $(this).removeClass('hover');
    });
  });
  
  $('#stars li').on('click', function(){
    var onStar = parseInt($(this).data('value'), 10); // The star currently selected
    var stars = $(this).parent().children('li.star');
    
    for (i = 0; i < stars.length; i++) {
      $(stars[i]).removeClass('selected');
    }
    
    for (i = 0; i < onStar; i++) {
      $(stars[i]).addClass('selected');
    }
  }); 
});