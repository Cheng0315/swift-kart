$(function(){
  $(".add-to-cart-btn").parent().on('click', function(event) {
    const id = $(this).children('button').attr('id');
    
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize()
    }).done(function(items_count) {
      $('.num-of-items').text(items_count)
    })
      
    $(`form.button_to button#${id}`).html("<i class='fas fa-spinner fa-fw fa-spin'></i>&nbsp Processing");
    setTimeout( function() {$(`form.button_to button#${id}`).html("<i class='fas fa-check'>&nbsp</i> Add to cart"); },450);
    
    event.preventDefault();
  });
});