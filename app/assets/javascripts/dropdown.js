/* global $ */

// dropdown function that removes "hidden" class from dropdown while
// adding hideDropdown listener to document and cleaning up out-of-date listener
const revealDropdown = (event) => {
  event.stopPropagation(); // prevent event from being picked up by body
  $("#dropdown").removeClass("hidden");
  $("#user_options").off("click", revealDropdown);
  $(document).on("click", hideDropdown);
};

// add "hidden" class to dropdown and update event listeners
const hideDropdown = () => {
  $("#dropdown").addClass("hidden");
  $("#user_options").on("click", revealDropdown);
  $(document).off("click", hideDropdown);
};

// Add click listener to gear icon which invokes reveal function
$(() => $("#user_options").on("click", revealDropdown));
