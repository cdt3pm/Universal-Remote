class CommandsController < ApplicationController
	def execute
		command = Command.find(params.require(:id))
		command.execute
		render nothing: true
	end
end
