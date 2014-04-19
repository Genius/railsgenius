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

    var idealLeftPositionIfEnoughSpace = $abstract.position().left - $annotationTooltip.outerWidth() - 30
    var minLeftEdgeBuffer = 20

    var left = idealLeftPositionIfEnoughSpace
    var top = $annotationReferent.position().top

    if (idealLeftPositionIfEnoughSpace < minLeftEdgeBuffer) {
      left = minLeftEdgeBuffer
      top += 50
    }

    $annotationTooltip.css({left: left + "px", top: top + 'px'}).show()
  }

  var getFirstSelection = function() {
    var selection = rangy.getSelection()
    return selection.rangeCount ? selection.getRangeAt(0) : null
  }

  var setupCreateNewAnnotationButton = function() {
    var $talkAbstract = $('.talk-abstract')
    if (!$talkAbstract.length) return

    $talkAbstract.off('mouseup.annotate').on('mouseup.annotate', function(e) {
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

    $(document).off('mousedown.annotate').on('mousedown.annotate', function() {
      var $annotateButton = $('#annotate-button:not([data-loading])')

      if ($annotateButton.length) {
        $annotateButton.hide()
        var $pendingA = $talkAbstract.find('a[data-pending]')
        $pendingA.replaceWith($pendingA.html())
      }
    })

    $('#annotate-button').off('mousedown.annotate').on('mousedown.annotate', function() {
      var $annotateButton = $(this)
      $annotateButton.attr('data-loading', true)

      $.ajax({
        type: 'POST',
        url: $annotateButton.attr('data-create-annotation-path'),
        data: { annotation: {body: ''} },
        dataType: 'json',
      }).success(function(annotation) {
        $('a[data-pending]').attr('data-id', annotation.id).removeAttr('data-pending')

        $.ajax({
          type: 'POST',
          dataType: 'json',
          url: $annotateButton.closest('.talk').attr('data-update-path'),
          data: { talk: { 'abstract': $('.talk-abstract').html() }, '_method': 'PATCH' }
        }).success(function(talk_json, status, xhr) {
          $annotateButton.removeAttr('data-loading').hide()

          Perspectives.renderResponse({
            json: talk_json,
            status: status,
            xhr: xhr,
            noPushState: true
          })

          Perspectives.navigate({
            href: annotation.edit_href,
            container: annotation.perspectives_target
          })
        })
      })

      return false
    })
  }

  $(document).on('any-page-load', setupCreateNewAnnotationButton)
  $(document).on('any-page-load', positionAnnotationTooltip)

  $(window).resize(function() { $.doTimeout('position-tooltip', 50, positionAnnotationTooltip) })
})(jQuery, document, window)
