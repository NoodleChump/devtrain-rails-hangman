// $(function() {
//   if ($("#game-spectate").length > 0) {
//     setTimeout(update, 2000);
//   }
// });
//
// function update () {
//   if ($("#game-spectate").length == 0) {
//     return // To stop polling when game is over
//   }
//
//   var game_id = $("#game-spectate").attr("data-id");
//   var time = $(".guess:last-child").attr("data-time");
//   var over = $("#game-spectate").attr("data-game-over");
//
//   $.getScript("/guesses.js?game_id=" + game_id + "&after=" + time);
//   $.getScript("/games/" + game_id + ".js");
//
//   setTimeout(update, 2000);
// };

$(function() {
  $("#clear-notifications").on("click", clearNotifications);
});

function clearNotifications() {
  $(".unread").removeClass("unread");
  $("#notifications-dropdown").removeClass("open");
  $("#notifications-dropdown").addClass("closed");
}
