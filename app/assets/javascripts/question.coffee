jQuery(document).on 'turbolinks:load', ->
  answers = $('#answers')
  answers.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn(1000)
  answers.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(1000)
