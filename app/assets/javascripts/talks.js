(function($, document, window, undefined) {
  var setup_annotation_click_handlers = function() {
    var $abstract = $('.talk-abstract')
    var $annotation_tooltip = $('#annotation-tooltip')

    $abstract.on('click', 'a[data-id]', function() {
      if ($('#annotate-button[data-loading]').length) return false
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

  var getFirstSelection = function() {
    var selection = rangy.getSelection()
    return selection.rangeCount ? selection.getRangeAt(0) : null
  }

  var setupCreateNewAnnotationButton = function() {
    var $talk_abstract = $('.talk-abstract')
    if (!$talk_abstract.length) return

    $talk_abstract.on('mouseup', function(e) {
      var $this = $(this)
      if (e.which != 1) return

      $this.doTimeout('abstract-mouseup', 100, function() {
        if ($('#annotate-button[data-loading]').length) return

        var selection = getFirstSelection()
        if (!selection || !$.trim(selection.toString()).length) return

        selection.surroundContents($('<a>', {'data-pending': 'true', 'data-no-perspectives': true})[0])
        $('#annotate-button').show().css({top: e.pageY - 50, left: e.pageX})
      })
    })

    $(document).on('mousedown', function() {
      var $annotate_button = $('#annotate-button:not([data-loading])')

      if ($annotate_button.length) {
        $annotate_button.hide()
        var $pending_a = $talk_abstract.find('a[data-pending]')
        $pending_a.replaceWith($pending_a.html())
      }
    })

    $('#annotate-button').mousedown(function() {
      var $this = $(this)
      $this.attr('data-loading', true)

      return false
    })
  }

  // TODO: abstract this
  $(setupCreateNewAnnotationButton)
  $(document).on('perspectives:load', setupCreateNewAnnotationButton)
})(jQuery, document, window)
