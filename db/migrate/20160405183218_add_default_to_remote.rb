class AddDefaultToRemote < ActiveRecord::Migration
  def change
		change_table :remotes do |t|
			t.boolean :is_default, default: false
		end

		reversible do |migration|
			migration.up do
				remote = Remote.create(name: 'Default', display: 'Default', is_default: 1)
				Command.create(name: 'Wait', display: 'Wait', remote_id: remote.id)
			end

			migration.down do
				remote_ids = Remote.where(is_default: true).select(:id).collect(&:id)
				say "found the following default remote(s): #{remote_ids}"
				Command.delete_all(remote_id: remote_ids)
				Remote.delete(remote_ids)
			end
		end
  end
end
