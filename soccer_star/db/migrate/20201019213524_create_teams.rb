class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :country
      t.boolean :professional_team

      t.timestamps
    end
  end
end
