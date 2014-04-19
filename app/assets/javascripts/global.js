(function($, document, window, undefined) {
  $(function() {
    $(document).perspectives('a:not([data-no-perspectives])', '#perspectives')
  })

  $(document).on('perspectives:load', function(event, xhr) {
    $('#perspectives')[0].className = xhr.getResponseHeader('x-container-classes')

    var flash = xhr.getResponseHeader('x-flash-perspective')
    if (flash && flash.length) {
      $('#flash-container').html(Perspectives.render(JSON.parse(flash)))
    } else {
      $('#flash-container').empty()
    }
  })

  $(document).on('perspectives:load', function() { $(document).trigger('any-page-load') })
  $(function() { $(document).trigger('any-page-load') })
})(jQuery, document, window)
