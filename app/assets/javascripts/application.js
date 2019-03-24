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
//= require handlebars
//= require_tree ./templates
//= require_tree .


Handlebars.registerHelper('times', function(n, block) {
  let accum = '';
  for(let i = 0; i < n; ++i)
      accum += block.fn(i);
  return accum;
});


$(function(){
  
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
