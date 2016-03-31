class ProvisionFromLircConfiguration < ActiveRecord::Migration
	CONFIG_PATH = '/etc/lirc/lircd.conf'
	LOCAL_CONFIG_PATH = '/home/pi/lircd.conf'

	def up
		say "Copying #{CONFIG_PATH} to #{LOCAL_CONFIG_PATH}"
		`cp #{CONFIG_PATH} #{LOCAL_CONFIG_PATH}`
		config_file = File.new(LOCAL_CONFIG_PATH, 'r')
		in_codes_block = false
		in_remote_block = false
		remote = nil

		config_file.each_line do |line|
			line.strip!

			if line == 'begin remote'
				say 'Found start of remote block'
				in_remote_block = true
			elsif line == 'end remote'
				say 'Found end of remote block'
				in_remote_block = false
				remote = nil
			elsif in_remote_block
				if (matches = /name[\s\t]+([\w_\- ]+)/.match(line)) && (name = matches[1])
					say "Creating remote with name #{name}"
					remote = Remote.find_or_create_by!(name: name) do |r|
						r.display = name
					end
					say "Remote id is #{remote.id}"
				elsif /begin codes/i.match(line)
					say 'Found start of codes block'
					in_codes_block = true
				elsif /end codes/.match(line)
					say 'Found end of codes block'
					in_codes_block = false
				elsif in_codes_block && remote && (matches = /[\w_]+/.match(line))
					say "found match with name #{matches[0]}"
					command = Command.find_or_create_by(name: matches[0], remote_id: remote.id) do |command|
						command.display = name
					end
				end
			end
		end
	end

  def down
  end
end
