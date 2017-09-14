class AddTournametToPhase < ActiveRecord::Migration[5.1]
  def change
    add_reference :phases, :tournament, foreign_key: true, index: true
  end
end
