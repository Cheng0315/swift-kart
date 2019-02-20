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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .



  var price1 = 0;
  var price2 = 0;
  var price3 = 0;
  var price4 = 0;
  var price5 = 0;
  var price6 = 0;
  var price7 = 0;
  var price8 = 0;
  var price9 = 0;
  var price10 = 0;
  
  function total_price_1(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price1 = 0;
    } else {
      price1 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_2(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price2 = 0;
    } else {
      price2 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_3(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price3 = 0;
    } else {
      price3 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_4(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price4 = 0;
    } else {
      price4 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_5(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price5 = 0;
    } else {
      price5 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_6(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price6 = 0;
    } else {
      price6 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_7(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price7 = 0;
    } else {
      price7 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_8(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price8 = 0;
    } else {
      price8 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_9(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price9 = 0;
    } else {
      price9 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }

  function total_price_10(idx, item_price, all_items_price) {
    var quantity = document.getElementById(`my_select_${idx}`).value;

    if (quantity == 1) {
      price10 = 0;
    } else {
      price10 = item_price * quantity - item_price;
    }
    total_sums = all_items_price + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
    document.getElementById("quantity_price").innerHTML = "$" + total_sums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
  }
