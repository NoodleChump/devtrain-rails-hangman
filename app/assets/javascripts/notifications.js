$(function() {
  if ($("#notifications-dropdown").length > 0) {
    $(".clear-notifications").on("click", clearNotifications);
    setTimeout(updateNotifications, 5000);
  }
});

function clearNotifications() {
  $("#notifications-dropdown").removeClass("open");
  $(".unread").removeClass("unread");
}

function updateNotifications () {
  if ($("#notifications-dropdown").length == 0) {
    return // To stop polling when no longer logged in
  }

  var user_id = $("#user-dropdown").attr("data-id");
  $.getScript("/notifications.js?user_id=" + user_id);

  $(".clear-notifications").on("click", clearNotifications);
  setTimeout(updateNotifications, 5000);
};
