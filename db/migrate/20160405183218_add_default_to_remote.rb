class AddDefaultToRemote < ActiveRecord::Migration
  def change
		change_table :remotes do |t|
			t.binary :default, default: false
		end

		Remote.create(name: 'Default', display: 'Default', default: true)
  end
end
