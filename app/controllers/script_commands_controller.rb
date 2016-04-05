class ScriptCommandsController < ApplicationController
	def create
	end

	def edit
		@command = ScriptCommand.find(params.require(:id))
	end

	def update
	end

	def delete
		ScriptCommand.delete(params.require(:id))
	end
end
