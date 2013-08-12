(function($) {
  $(document).ready(function() {
    $("#project_about .text").mCustomScrollbar();
    $("[data-controller-name=\"backers\"] #page_content .container").mCustomScrollbar({
      advanced: {
        updateOnContentResize: true
      }
    });
    $(".static_default .textos").mCustomScrollbar();
  })
})(jQuery);
