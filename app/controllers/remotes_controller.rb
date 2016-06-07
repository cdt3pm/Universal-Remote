class RemotesController < ApplicationController
	def index
		@remotes = Remote.all
	end

	def new
	end

	def commands
		id = params.require(:id)
		commands = Command.where(remote_id: id)
		render json: commands
	end

	def show
		id = params.require(:id)
		@remote = Remote.find(id)
	end

	def edit
		id = params.require(:id)
		@remote = Remote.find(id)
	end

	def update
		remote = Remote.find(params.require(:id))
		remote.update!(remote_params.permit(:name, :display))
	end

	def delete
	end
end
