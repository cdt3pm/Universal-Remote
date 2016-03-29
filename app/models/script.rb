class Script < ActiveRecord::Base
	has_many :script_commands, dependent: :delete_all
	has_many :commands, through: :script_commands
	has_many :remotes, through: :commands
end
