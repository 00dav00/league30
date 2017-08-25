class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.integer :required_teams, null: false
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end
