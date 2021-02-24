class AddBioToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :bio, :text
  end
end
