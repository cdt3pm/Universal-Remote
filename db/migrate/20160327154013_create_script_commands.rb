class CreateScriptCommands < ActiveRecord::Migration
  def change
    create_table :script_commands do |t|
			t.string :description
			t.integer :duration
			t.belongs_to :script
			t.belongs_to :command

      t.timestamps null: false
    end
  end
end
