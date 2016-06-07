# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('button.command').click -> $.get('/commands/' + $(this).attr('id') + '/execute')
	dispatcher = new WebSocketRails 'http://pi:3000/websocket'
	dispatcher.subscribe('remotes').bind 'output', output -> console.log 'OUTPUT ' + output
	console.log 'triggering new remote'
	dispatcher.trigger 'remotes.new_remote'
