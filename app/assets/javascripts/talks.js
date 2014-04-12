(function($, document, window, undefined) {
  var setup_annotation_click_handlers = function() {
    var $abstract = $('.talk-abstract')
    var $annotation_tooltip = $('#annotation-tooltip')

    $abstract.on('click', 'a[data-id]', function() {
      var $annotation_referent = $(this)

      $.get(this.href, function(content) {
        $annotation_tooltip.html(content)
        $annotation_tooltip.css({
          position: 'absolute',
          top: $annotation_referent.position().top + 'px',
          left: "-10000px"
        }).focus()

        $annotation_tooltip.css({left: ($abstract.position().left - $annotation_tooltip.outerWidth() - 30) + "px"}).show()
      })

      return false
    })
  }

  $(setup_annotation_click_handlers)
  $(document).on('perspectives:load', setup_annotation_click_handlers)
})(jQuery, document, window)
