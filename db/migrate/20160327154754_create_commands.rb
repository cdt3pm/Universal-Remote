class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
			t.string :name
			t.string :display
			t.belongs_to :remote

      t.timestamps null: false
    end
  end
end
