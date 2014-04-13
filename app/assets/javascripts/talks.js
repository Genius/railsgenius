(function($, document, window, undefined) {
  var positionAnnotationTooltip = function() {
    var $abstract = $('.talk-abstract')
    var $annotationTooltip = $('#annotation-tooltip')

    var $expandedAnnotation = $annotationTooltip.find('.annotation')
    if (!$expandedAnnotation.length) return
    var $annotationReferent = $abstract.find('a[data-id=' + $expandedAnnotation.attr('data-id') + ']')

    $annotationTooltip.css({
      position: 'absolute',
      top: $annotationReferent.position().top + 'px',
      left: "-10000px"
    }).focus()

    $annotationTooltip.css({left: ($abstract.position().left - $annotationTooltip.outerWidth() - 30) + "px"}).show()
  }

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
        if ($('<div>').append(selection.toHtml()).find('a[data-id]').length) return alert("Sorry, you can only annotate unannotated text!")

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
      var $annotate_button = $(this)
      $annotate_button.attr('data-loading', true)

      $.ajax({
        type: 'POST',
        url: $annotate_button.attr('data-create-annotation-path'),
        data: { annotation: {body: ''} },
        dataType: 'json',
      }).success(function(annotation) {
        $('a[data-pending]').attr('data-id', annotation.id).removeAttr('data-pending')

        $.ajax({
          type: 'POST',
          dataType: 'json',
          url: $annotate_button.closest('.talk').attr('data-update-talk-path'),
          data: { talk: { 'abstract': $('.talk-abstract').html() }, '_method': 'PATCH' }
        }).success(function(talk) {
          $annotate_button.removeAttr('data-loading').hide()

          $('.talk-abstract').html(talk.abstract)
        })
      })

      return false
    })
  }

  $(document).on('any-page-load', setupCreateNewAnnotationButton)
  $(document).on('any-page-load', positionAnnotationTooltip)
})(jQuery, document, window)
