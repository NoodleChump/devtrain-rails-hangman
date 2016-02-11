$(function() {
  if ($("#notifications-dropdown").length > 0) {
    $(".clear-notifications").on("click", clearNotifications);
    setTimeout(updateNotifications, 5000);

    toastr.options = {
      "closeButton": true,
      "positionClass": "toast-bottom-right",
      "progressBar": true,
    };
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

  var unreadNotificationsBefore = $('.notification.unread').length;
  console.log("before: " + unreadNotificationsBefore);

  var user_id = $("#user-dropdown").attr("data-id");
  $.getScript("/notifications.js?user_id=" + user_id).done(function(script, textStatus) {
    var unreadNotifications = $('.notification.unread').length;

    console.log("after: " + unreadNotifications);
    if (unreadNotificationsBefore != unreadNotifications) {
      if (unreadNotifications == 1) {
        toastr.info('You have ' + unreadNotifications + ' unread notification');
      } else if (unreadNotifications > 0) {
        toastr.info('You have ' + unreadNotifications + ' unread notifications');
      }
    }
  });

  setTimeout(updateNotifications, 5000);
};
