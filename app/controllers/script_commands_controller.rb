class ScriptCommandsController < ApplicationController
	def create
	end

	def edit
		@command = ScriptCommand.find(params.require(:id))
	end

	def update
		command = ScriptCommand.find(params.require(:id))
		updated_attributes = params.require(:script_command).permit(:description, :command_id, :duration)
		command.update(updated_attributes)

		render nothing: true
	end

	def destroy
		ScriptCommand.delete(params.require(:id))
		render nothing: true
	end
end
