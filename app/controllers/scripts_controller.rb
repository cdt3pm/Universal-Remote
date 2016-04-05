class ScriptsController < ApplicationController
	def edit
		id = params.require(:id)
		@script = Script.find(id)
	end

	def new_command
		command = ScriptCommand.create(
			description: ScriptCommand.DEFAULT_DESCRIPTION,
			command_id: Command.default_id,
			script_id: params.require(:id)
		)
		redirect_to edit_script_command_path, id: command.id
	end
end
