$(document).on('turbolinks:load', function(){

  $(".sort-reviews").change(function() {
    const sortBy = $(this).val();
    
    $.ajax({
      type: 'GET',
      url: "/sort_reviews",
      data: {sortBy: sortBy}
    }).done(function(reviews) {
      console.log(reviews)
    })
  })

})