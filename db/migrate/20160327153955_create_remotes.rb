class CreateRemotes < ActiveRecord::Migration
  def change
    create_table :remotes do |t|
			t.string :name
			t.string :display

      t.timestamps null: false
    end
  end
end
