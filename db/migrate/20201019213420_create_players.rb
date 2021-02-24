class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :gender
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
