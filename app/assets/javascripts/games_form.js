$(function() {
  var $customWordField = $('.custom-word-field');
  var $customWordCheckbox = $('.custom-word-checkbox');
  var $actions = $('.actions')

  console.log($actions.data('custom-word'));
  console.log($actions.data('random-word'));
  console.log($actions.data('custom-word-checked'));

  var showCustomWordField = function() {
    $customWordField.css("max-height", 60);
    $customWordField.css("opacity", 1);
    $customWordField.css("visibility", "visible");
  };

  var hideCustomWordField = function() {
    $customWordField.css("max-height", 0);
    $customWordField.css("opacity", 0);
    setTimeout(function() {
      $customWordField.css("visibility", "hidden");
    }, 500);
  }

  // When the checkbox is toggled, show/hide the custom word field
  $customWordCheckbox.change(function(e) {
    if ($(this).is(":checked"))  {
      showCustomWordField();
    } else {
      hideCustomWordField();
    }
  });

  // If the field for the custom word was showing, make it expanded by default again
  if ($actions.data('custom-word-checked')) {
    $customWordCheckbox.prop('checked', true);
    $customWordField.addClass('notransition');
    showCustomWordField();
    $customWordField[0].offsetHeight;
    $customWordField.removeClass('notransition');
  }

  // Set word to either the last custom word, or a random word by default
  if ($customWordCheckbox.is(":checked"))  {
    $('#game_word_to_guess').val($actions.data("custom-word"));
  } else {
    $('#game_word_to_guess').val($actions.data('random-word'));
  }

  // Set default number of lives
  if ($('#game_number_of_lives').val() == "")  {
    $('#game_number_of_lives').val("5")
  }

  $("#game_player_id").focus();
});
