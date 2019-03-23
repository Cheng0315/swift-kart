const dateFormat = (date) => {
  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  const newD = new Date(date);
  const d = newD.getDate();
  const m = newD.getMonth();
  const y = date.substring(0, 4);

  return monthNames[m] + " " + d + ', ' + y
}

$(document).on('turbolinks:load', function(){
  $("#dynamic_submit_form").on('submit', function(event) {
    
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize()
    }).done(function(review) {

      if (review) {
        let user = review.user
        let total_reviews = parseInt($('a#total_reviews').data('total_reviews'))
        review.created_at = dateFormat(review.created_at);
        review.hollowStars = 5 - review.rating;
        
        $('#total_reviews').html(`<a href='#reviews' id='total_reviews' data-total_reviews='${total_reviews + 1}'>${total_reviews + 1} customers reviews</a>`)
        $('#list-reviews').append(HandlebarsTemplates['append_review']({review: review, user: user}))
        $("#dynamic_submit_form").hide()

      } else {
        location.reload();
        alert('Please fill in all the fields!')
      }
    })
    
    event.preventDefault();
  })
})