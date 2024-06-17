class AddScamStrategyToScams < ActiveRecord::Migration[7.1]
  def change
    add_column :scams, :scam_strategy, :text, null: false
  end
end
