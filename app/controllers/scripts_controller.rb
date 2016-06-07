class ScriptsController < ApplicationController
	def new
		@script = Script.new
	end

	def create
		script = Script.create(params.require(:script).permit(:name))
		redirect_to action: 'edit', id: script.id
	end

	def edit
		@script = Script.find(params.require(:id))
	end

	def update
		script = Script.find(params.require(:id))
		updated_attributes = params.require(:script).permit(:name)
		script.update(updated_attributes)

		redirect_to action: 'edit', id: script.id
	end

	def destroy
		Script.delete(params.require(:id))
		render nothing: true
	end

	def new_command
		command = ScriptCommand.create(
			description: ScriptCommand::DEFAULT_DESCRIPTION,
			command_id: Command.default_id,
			script_id: params.require(:id)
		)
		render partial: 'script_commands/form', locals: { c: command }
	end

	def execute
		Script.find(params.require(:id)).execute
		render nothing: true
	end
end
