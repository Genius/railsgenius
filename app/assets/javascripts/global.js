(function($, document, window, undefined) {
  $(function() {
    $(document).perspectives('a:not([data-no-perspectives])', '#perspectives')
  })

  $(document).on('perspectives:load', function(event, xhr) {
    $('#perspectives')[0].className = xhr.getResponseHeader('x-container-classes')

    var flash = xhr.getResponseHeader('x-flash-perspective')
    if (flash && flash.length) {
      $('#flash-container').html(LP.render(flash))
    } else {
      $('#flash-container').empty()
    }
  })
})(jQuery, document, window)
