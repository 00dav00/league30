class CreatePhases < ActiveRecord::Migration[5.1]
  def change
    create_table :phases do |t|
      t.string :name, null: false
      t.integer :position_in_tournament, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
