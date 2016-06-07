class CommandLineController < WebsocketRails::BaseController
	def start
		logger.debug 'stopping services'
		`sudo service lirc stop`
		logger.debug 'opening pipe, starting irrecord'
		@@stdin, @@stdout = Open3.popen2e('irrecord -d /dev/lirc0 ~/new_remote.conf')

		logger.debug 'starting thread'
		Thread.new do
			while line = @@stdout.gets do
				logger.debug "line is #{line}"
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
end
