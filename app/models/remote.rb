class Remote < ActiveRecord::Base
	has_many :commands, dependent: :delete_all
	has_many :script_commands, through: :commands
	has_many :scripts, through: :commands
end
