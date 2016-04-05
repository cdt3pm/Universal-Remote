class ScriptCommand < ActiveRecord::Base
	DEFAULT_DESCRIPTION = "Enter a description"

	belongs_to :script
	belongs_to :command
end
