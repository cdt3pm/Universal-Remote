# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	deleteForms = $('.deleteScript').parents('form.button_to')
	deleteForms.on 'ajax:success', -> $(this).parents('.scriptContainer').remove()
	deleteForms.on 'ajax:error', (e) -> $(this).parents('.scriptContainer').show()
