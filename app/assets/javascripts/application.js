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
  let accum = '';
  for(let i = 0; i < n; ++i)
      accum += block.fn(i);
  return accum;
});


$(document).on('turbolinks:load', function(){
  function toggleDropdown (e) {
    const dropdown = $(e.target).closest('.dropdown'),
      menu = $('.dropdown-menu', dropdown);
    setTimeout(function(){
      const shouldOpen = e.type !== 'click' && dropdown.is(':hover');
      menu.toggleClass('show', shouldOpen);
      dropdown.toggleClass('show', shouldOpen);
      $('[data-toggle="dropdown"]', dropdown).attr('aria-expanded', shouldOpen);
    }, e.type === 'mouseleave' ? 300 : 0);
  }
  
  $('body')
    .on('mouseenter mouseleave','.dropdown',toggleDropdown)
    .on('click', '.dropdown-menu a', toggleDropdown);

})


$(document).on('turbolinks:load', function(){
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