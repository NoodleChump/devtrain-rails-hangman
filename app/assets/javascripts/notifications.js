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

  var unreadNotificationsBefore = $('.notification.unread').length;

  var user_id = $("#user-dropdown").attr("data-id");
  $.getScript("/notifications.js?user_id=" + user_id).done(function(script, textStatus) {
    var unreadNotifications = $('.notification.unread').length;

    // if (unreadNotificationsBefore != unreadNotifications) {
    //   if (unreadNotifications == 1) {
    //     toastr.info('You have ' + unreadNotifications + ' unread notification');
    //   } else if (unreadNotifications > 0) {
    //     toastr.info('You have ' + unreadNotifications + ' unread notifications');
    //   }
    // }
    var numNewUnreadNotifications = unreadNotifications - unreadNotificationsBefore;
    var newUnreadNotifications = $(".notification.unread").slice(0, numNewUnreadNotifications);

    newUnreadNotifications.each(function(index) {

      toastr.options = {
        "closeButton": true,
        "positionClass": "toast-bottom-right",
        "progressBar": true,
        "onclick": function() {
          $(".notification.unread:eq(" + index + ")").find("a")[0].click();
        }
      }

      toastr["info"]($(this).text())
    });

  });

  setTimeout(updateNotifications, 5000);
};
