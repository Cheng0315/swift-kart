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
//= require handlebars
//= require_tree ./templates
//= require_tree .


Handlebars.registerHelper('times', function(n, block) {
  var accum = '';
  for(var i = 0; i < n; ++i)
      accum += block.fn(i);
  return accum;
});

function dateFormat(date) {
  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  let newD = new Date(date);
  let d = newD.getDate();
  let m = newD.getMonth();
  let y = date.substring(0, 4);

  return monthNames[m] + " " + d + ', ' + y
}

function pluralize(quantity) {
  if (quantity === 1) {
    return '1 items'
  } else {
    return `${quantity} items`
  }
}


  

  $(document).on('turbolinks:load', function(){
    let price1 = 0; let price11 = 0; let quantity1 = 0; let quantity11 = 0; 
    let price2 = 0; let price12 = 0; let quantity2 = 0; let quantity12 = 0; 
    let price3 = 0; let price13 = 0; let quantity3 = 0; let quantity13 = 0; 
    let price4 = 0; let price14 = 0; let quantity4 = 0; let quantity14 = 0; 
    let price5 = 0; let price15 = 0; let quantity5 = 0; let quantity15 = 0; 
    let price6 = 0; let price16 = 0; let quantity6 = 0; let quantity16 = 0; 
    let price7 = 0; let price17 = 0; let quantity7 = 0; let quantity17 = 0; 
    let price8 = 0; let price18 = 0; let quantity8 = 0; let quantity18 = 0; 
    let price9 = 0; let price19 = 0; let quantity9 = 0; let quantity19 = 0; 
    let price10 = 0; let price20 = 0; let quantity10 = 0; let quantity20 = 0; 
    
    let totalQuantity = parseInt($("#num-of-items").text());

    

    $(".select-quantity").change(function() {
      let idx = parseFloat($(this).attr('data-idx'));
      let itemPrice = parseFloat($(this).attr('data-price'));
      let totalPrice = parseFloat($(this).attr('data-total-price'));
      let quantity = parseFloat($('#' + $(this).attr('id')).val());
      let quantityPrice = itemPrice * quantity - itemPrice;
      
      if (quantity == 1) {
        eval('price' + (idx + 1) + '= 0;');
        eval('quantity' + (idx + 1) + '= 0;');
      } else {
        eval('price' + (idx + 1) + `= ${quantityPrice}`);
        eval('quantity' + (idx + 1) + `= ${quantity - 1}`);
      }

      totalPriceSums = totalPrice + price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10 + price11 + price12 + price13 + price14 + price15 + price16 + price17 + price18 + price19 + price20;
      totalQuantitySums = totalQuantity + quantity1 + quantity2 + quantity3 + quantity4 + quantity5 + quantity6 + quantity7 + quantity8 + quantity9 + quantity10 + quantity11 + quantity12 + quantity13 + quantity14 + quantity15 + quantity16 + quantity17 + quantity18 + quantity19 + quantity20;
      
      $("#quantity_price").text("$" + totalPriceSums.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'))
      $("#num-of-items").text(totalQuantitySums)
      $("#items-total").text(pluralize(totalQuantitySums))
    })
  })


  $(document).on('turbolinks:load', function(){
    
    /*$("#render_review_form").on('click', function() {
      let token = $('meta[name="csrf-token"]').attr('content')
      let item_id = $(this).data('item_id')
      $("#render_review_form").hide()
      $("#show_page_review_form_div").html(HandlebarsTemplates['review_form']({token: token, item_id: item_id}))
    })*/

    $("#dynamic_submit_form").on('submit', function(event) {
      
      $.ajax({
        type: "POST",
        url: this.action,
        data: $(this).serialize()
      }).done(function(review) {
        let user = review.user
        review.created_at = dateFormat(review.created_at);
        review.stars = 5 - review.rating;
        $('.list-reviews').append(HandlebarsTemplates['list_reviews']({review: review, user: user}))
        $("#dynamic_submit_form").hide()
      })
      event.preventDefault();
    })
  })
  
  

$(document).on('turbolinks:load', function(){

  $(".add-to-cart-btn").parent().on('click', function(event) {
    
    var id = $(this).children('button').attr('id');
   
    console.log(id);
    
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize()
    }).done(function(items_count) {
      $('#num-of-items').text(items_count)
    })
      
    $(`form.button_to button#${id}`).html("<i class='fas fa-spinner fa-fw fa-spin'></i>&nbsp Processing");
    setTimeout( function() {$(`form.button_to button#${id}`).html("<i class='fas fa-check'>&nbsp</i> Add to cart"); },450);
    
    event.preventDefault();
  });


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
    var onStar = parseInt($(this).data('value'), 10); 
    var stars = $(this).parent().children('li.star');
    
    for (i = 0; i < stars.length; i++) {
      $(stars[i]).removeClass('selected');
    }
    
    for (i = 0; i < onStar; i++) {
      $(stars[i]).addClass('selected');
    }

    $('#review_rating').attr('value', onStar);
  });
  
  
});