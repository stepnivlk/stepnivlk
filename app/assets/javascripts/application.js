// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.sticky.js
//= require bootstrap-sprockets
//= require nested_form_fields
//= require bootstrap-datepicker
//= require_tree .
$(document).ready(function() {

  $('a[href*=#]').bind("click", function(e){          
    var anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $(anchor.attr('href')).offset().top
    }, 1000);
    e.preventDefault();
  });

  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      $('.scroll-up').fadeIn();
    } else {
      $('.scroll-up').fadeOut();
    }
  });

  $('.input-daterange').datepicker();
  $('.header').sticky({
    topSpacing: 0
  });

  $(".screen-height").height($(window).height());

  $(window).resize(function(){
    $(".screen-height").height($(window).height());
  });

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)) {
    $('#home').css({'background-attachment': 'scroll'});
  } else {
    $('#home').parallax('50%', 0.1);
  }


});