class RemotesController < ApplicationController
	def index
		@remotes = Remote.all
	end

	def new
	end

	def start
		`sudo service lirc stop`
		@@stdin, @@stdout = Open3.popen2e('irrecord -d /dev/lirc0 ~/new_remote.conf')

		Thread.new do
			while line = @@stdout.gets do
				# write to channel
				WebsocketRails[:remotes].trigger(:output, line)
			end
		end
	end

	def input
		@@stdin.write message if @@stdin
	end

	def cancel
		@@stdin.close if @@stdin
		@@stdout.close if @@stdout
		@@stdin = nil
		@@stdout = nil
		`sudo service lirc start`
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
