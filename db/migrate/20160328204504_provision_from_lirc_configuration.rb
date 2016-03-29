class ProvisionFromLircConfiguration < ActiveRecord::Migration
	CONFIG_PATH = '/etc/lirc/licrd.conf'

	def up
		config_file = File.new(CONFIG_PATH)
		in_codes_block = false
		in_remote_block = false
		remote = nil

		config_file.each_line do |line|
			if line == 'begin remote'
				say 'Found start of remote block'
				in_remote_block = true
			elsif line == 'end remote'
				say 'Found end of remote block'
				in_remote_block = false
				remote = nil
			elsif in_remote_block
				if (matches = /name ([\w ]+)c/.match(line)) && (name = matches[1])
					say "Creating remote with name #{name}"
					remote = Remote.create(name: name, display: name)
				elsif /begin codes/i.match(line)
					say 'Found start of codes block'
					in_codes_block = true
				elsif /end codes/.match(line)
					say 'Found end of codes block'
					in_codes_block = false
				elsif in_codes_block && remote && (matches = /^[\w_]+/.match(line))
					say "Appending command with name #{name}"
					remote.commands << Command.new(name: matches[0], display: matches[0])
					remote.save
				end
			end
		end
	end

  def down
  end
end
