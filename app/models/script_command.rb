class ScriptCommand < ActiveRecord::Base
	belongs_to :script
	has_one :command
end
