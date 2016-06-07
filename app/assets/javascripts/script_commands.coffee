# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Subform
	@getOptions: (records, displayField, valueField) ->
		options = []
		options.push $('<option></option>').val(record[valueField]).text(record[displayField]) for record in records
		options
	constructor: (destination) ->
		@dirty = false
		@form = destination.find('.command-subform')
		deleteButton = destination.find('.delete')
		deleteForm = deleteButton.parents('form.button_to')
		deleteButton.click => destination.hide()
		deleteForm.on 'ajax:success', => destination.remove()
		deleteForm.on 'ajax:error', => destination.show()

		@form.change => @dirty = true
		@form.find('.remote').change => @remoteChanged()
	remoteChanged: ->
		val = @form.find('.remote').val()
		cachedOptions = commandCache[val]

		dependentElement = @form.find '#script_command_command_id'
		dependentElement.empty()

		if (cachedOptions)
			dependentElement.append option.clone() for option in cachedOptions
		else
			$.get '/remotes/' + val + '/commands'
				.done (records) =>
					options = Subform.getOptions records, 'name', 'id'
					commandCache[val] = options

					dependentElement.append option.clone() for option in options
				.fail (error) -> console.log error

commandCache = {}

$(document).on 'page:change', ->
	subforms = []

	$('div.script-command-container').each () -> subforms.push new Subform($(this))
	$('#addScriptCommand').click (e) ->
		$.get document.location.toString().replace('edit', 'new_command')
			.done (resp) ->
				form = $ resp
				$('#commands').append form
				subforms.push new Subform(form)
			.fail (err) -> console.log(err)
		true
	$('#saveSubforms').click -> subform.form.submit() for subform in subforms when subform.dirty
	$('#test').click -> $.get document.location.toString().replace('edit', 'execute')

