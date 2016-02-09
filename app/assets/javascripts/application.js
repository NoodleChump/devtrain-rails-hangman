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
//= require bootstrap
//= require turbolinks
//= require_tree .

// Fix for turbolinks conflicting with bootstrap dropdown menus
$('.dropdown-toggle').dropdown()

$(function() {
  if ($("#game-spectate").length > 0) {
    setTimeout(update, 2000);
  }
});

function update () {
  var game_id = $("#game-spectate").attr("data-id");
  var time = $(".guess:last-child").attr("data-time");

  $.getScript("/guesses.js?game_id=" + game_id + "&after=" + time)
  setTimeout(update, 2000);
}
