class Script < ActiveRecord::Base
	has_many :script_commands, dependent: :delete_all
	has_many :commands, through: :script_commands
	has_many :remotes, through: :commands

	accepts_nested_attributes_for :script_commands, allow_destroy: true

	def execute
		commands_for_execute.each { |sc| sc.execute }
	end

	def commands_for_execute
		ScriptCommand.where(script_id: id).includes(:command)
	end
end
