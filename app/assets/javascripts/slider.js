slider = function() {
  $("#completionSlider").slider({
      tooltip: 'always'
  });
};

$(document).ready(slider)
$(document).on('page:load', slider)