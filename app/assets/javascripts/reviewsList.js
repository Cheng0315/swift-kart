let gPathName = window.location.pathname

const isItemShowPath = (pathname) => {	
  if (!!pathname.match(/^\/items\/\d+$/g)) {	
    return true	
  } else {	
    return false	
  }	
}


$(function(){

  if (isItemShowPath(gPathName)) {
    let sortBy = 'oldest'
    let itemId = $("#show-image-info").attr('data-item_id')
    console.log(itemId)
    $.ajax({
      type: 'GET',
      url: "/sort_reviews",
      data: {sortBy: sortBy, itemId: itemId}
    }).done(function(reviews) {
      console.log(!!reviews.length)
      if (!!reviews.length) {
        console.log(reviews)
        reviews.forEach(function(review) {
          review.created_at = dateFormat(review.created_at);
          review.hollowStars = 5 - review.rating;
        })
        
        $('#list-reviews').html(HandlebarsTemplates['sort_reviews'](reviews))
      }
    })
  }
})