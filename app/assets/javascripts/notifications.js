$(function() {
  if ($("#user-dropdown").length > 0) {
    $("#clear-notifications").on("click", clearNotifications);
    setTimeout(updateNotifications, 5000);
  }
});

function clearNotifications() {
  $(".unread").removeClass("unread");
  $("#notifications-dropdown").removeClass("open");
  $("#notifications-dropdown").addClass("closed");
}

function updateNotifications () {
  if ($("#user-dropdown").length == 0) {
    return // To stop polling when no longer logged in
  }

  var user_id = $("#user-dropdown").attr("data-id");

  $.getScript("/notifications.js?user_id=" + user_id);

  //setTimeout(updateNotifications, 5000);
};
