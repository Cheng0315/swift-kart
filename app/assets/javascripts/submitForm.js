const dateFormat = (date) => {
  const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  const newD = new Date(date);
  const d = newD.getDate();
  const m = newD.getMonth();
  const y = date.substring(0, 4);

  return monthNames[m] + " " + d + ', ' + y
}

class Review {
  constructor(review) {
    this.id = review.id
    this.rating = review.rating
    this.comment = review.comment
    this.userId = review.user_id
    this.itemId = review.item_id
    this.createdAt = dateFormat(review.created_at);
    this.hollowStars = 5 - review.rating;
    this.userFirstName = review.user.first_name
    this.userLastName = review.user.last_name
  }

  userFullName () {
    return this.userFirstName + ' ' + this.userLastName
  }
}

$(function(){
  $("#dynamic_submit_form").on('submit', function(event) {
    
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize()
    }).done(function(review) {

      if (review) {
        const total_reviews = parseInt($('a#total_reviews').data('total_reviews'))
        const reviewInfo = new Review(review)
        
        $('#total_reviews').html(`<a href='#reviews' id='total_reviews' data-total_reviews='${total_reviews + 1}'>${total_reviews + 1} customers reviews</a>`)
        $('#list-reviews').append(HandlebarsTemplates['append_review'](reviewInfo))
        $("#dynamic_submit_form").hide()

      } else {
        location.reload();
        alert('Please fill in all the fields!')
      }
    })
    
    event.preventDefault();
  })
})