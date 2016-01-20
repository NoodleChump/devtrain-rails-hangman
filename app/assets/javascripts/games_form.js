$(function() {
  var $customWordWrapper = $('.custom-word-field');
  var $customWordField = $('#game_word_to_guess');
  var $customWordCheckbox = $('.custom-word-checkbox');
  var $actions = $('.actions');

  var showcustomWordWrapper = function() {
    $customWordWrapper.css("max-height", 60);
    $customWordWrapper.css("opacity", 1);
    $customWordWrapper.css("visibility", "visible");
  };

  var hidecustomWordWrapper = function() {
    customWordValue = $customWordWrapper.val()
    $customWordWrapper.css("max-height", 0);
    $customWordWrapper.css("opacity", 0);
    setTimeout(function() {
      $customWordWrapper.css("visibility", "hidden");
    }, 250);
  }

  // When the checkbox is toggled, show/hide the custom word field
  $customWordCheckbox.change(function(e) {
    if ($(this).is(":checked"))  {
      showcustomWordWrapper();
      $customWordField.select();
    } else {
      hidecustomWordWrapper();
    }
  });

  // If the field for the custom word was showing, make it expanded by default again
  if ($actions.data('custom-word-checked')) {
    $customWordCheckbox.prop('checked', true);
    $customWordWrapper.addClass('notransition');
    showcustomWordWrapper();
    $customWordWrapper[0].offsetHeight;
    $customWordWrapper.removeClass('notransition');
  } else {
    $customWordCheckbox.prop('checked', false);
  }

  $("#game_player_id").focus();
});
