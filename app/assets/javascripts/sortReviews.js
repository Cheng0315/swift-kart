$(document).on('turbolinks:load', function(){

  $(".sort-reviews").change(function() {
    const sortBy = $(this).val();
    const itemId = $(this).attr('data-item_id')
    
    $.ajax({
      type: 'GET',
      url: "/sort_reviews",
      data: {sortBy: sortBy, itemId: itemId}
    }).done(function(reviews) {
      reviews.forEach(function(ele) {
        console.log(ele.created_at)
      })
    })
  })

})