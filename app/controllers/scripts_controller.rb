class ScriptsController < ApplicationController
	def edit
		id = params.require(:id)
		@script = Script.find(id)
	end
end
