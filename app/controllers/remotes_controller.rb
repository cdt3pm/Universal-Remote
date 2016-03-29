class RemotesController < ApplicationController
	def index
		@remotes = Remote.all
	end

	def show
		id = params.requre(:id)
		@remote = Remote.find(id)
	end

	def edit
		id = params.require(:id)
		@remote = Remote.find(id)
	end

	def delete
	end
end
