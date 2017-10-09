class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :short_name, null: false
      t.string :name, null: false
      t.string :full_name, null: false
      t.string :logo_image, null: false

      t.timestamps
    end
  end
end
