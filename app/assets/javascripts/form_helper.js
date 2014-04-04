$(function() {
  $(document).on('submit', 'form', function() {
    var $this = $(this)

    if(!$this.find('.csrf-meta-tags').length) {
      $('<div>', {'class': 'csrf-meta-tags', style:"margin:0;padding:0;display:inline"}).
        append($('<input>', {name: "utf8", type: "hidden", value: "✓" })).
        append($('<input>', {name: "authenticity_token", type: "hidden", value: $('meta[name="csrf-token"]').attr('content')})).
        appendTo($this)
    }
  })
})
