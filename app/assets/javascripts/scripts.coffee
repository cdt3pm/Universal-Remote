# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Subform
	constructor: (@form) ->
		@dirty = false
		@form.change -> @form.submit()
		#@form.change -> @dirty = true
		#@form.blur -> @form.submit if @dirty

$('#addScriptCommand').click (e) ->
	$.get document.location + '/new_command',
		(resp) ->
			form = $ resp
			$('#commands').append form
			new Subform form
		(err) -> console.log(err)

$(document).ready ->
	$('#commands form').each (form) -> new Subform form

