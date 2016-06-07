class Command < ActiveRecord::Base
	COMMAND_TEMPLATE = 'irsend %s %s %s'
	SEND_START = 'SEND_START'
	SEND_STOP = 'SEND_STOP'
	SEND_ONCE = 'SEND_ONCE'

	belongs_to :remote
	has_many :script_commands, dependent: :delete_all
	has_many :scripts, through: :script_commands

	def self.default_id
		@default ||= Command.joins(:remote).where(remotes: { is_default: true }).first
		@default.id
	end

	def execute(duration = 0)
		if id == Command.default_id 
			# Default implies wait for slow devices
			logger.debug "waiting for #{duration} seconds"
			sleep(duration)
		elsif duration > 0
			hold_for(duration)
		else
			send_once
		end
	end

	def hold_for(number_of_seconds)
		logger.debug "holding #{name} for #{number_of_seconds}"
		# Log start of command
		execute_command(SEND_START)
		sleep(number_of_seconds)
		# Log stop of command
		execute_command(SEND_STOP)
	end

	def send_once
		logger.debug "pressing #{name}"
		execute_command(SEND_ONCE)
	end

	private
	def execute_command(action)
		`#{COMMAND_TEMPLATE % [action, remote.name, name]}`
	end
end
