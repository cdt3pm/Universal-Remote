class CommandsController < ApplicationController
	def execute
		command = Command.find(:id)
		command.execute
		render nothing: true
	end
end
