class CreateTournamentContestants < ActiveRecord::Migration[5.1]
  def change
    create_table :tournament_contestants do |t|
      t.belongs_to :team, index: true
      t.belongs_to :tournament, index: true
      t.index [:team_id, :tournament_id], unique: true, name: 'index_tournament_contestants'

      t.timestamps
    end

    add_column :tournaments, :contestants_count, :integer, default: 0
  end
end
