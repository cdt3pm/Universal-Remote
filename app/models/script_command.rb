class ScriptCommand < ActiveRecord::Base
	belongs_to :script
	belongs_to :command
end
