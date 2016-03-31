class Command < ActiveRecord::Base
	COMMAND_TEMPLATE = 'irsend %s %s %s'
	SEND_START = 'SEND_START'
	SEND_STOP = 'SEND_STOP'
	SEND_ONCE = 'SEND_ONCE'

	belongs_to :remote
	has_many :script_commands, dependent: :delete_all
	has_many :scripts, through: :script_commands

	def execute(param = nil)
		if remote
			if param then hold_for(param) else send_once end
		else
			# Assume wait
			sleep(param ? param : 1)
		end
	end

	def hold_for(number_of_seconds)
		# Log start of command
		execute_command(SEND_START)
		sleep(number_of_seconds)
		# Log stop of command
		execute_command(SEND_STOP)
	end

	def send_once
		execute_command(SEND_ONCE)
	end

	private
	def execute_command(action)
		`#{COMMAND_TEMPLATE % [action, remote.name, name]}`
	end
end
