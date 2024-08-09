class AddScamStrategyToScams < ActiveRecord::Migration[7.0]
  def change
    add_column :scams, :scam_strategy, :text, null: false
  end
end
