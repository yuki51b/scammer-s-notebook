class AddPointsToScams < ActiveRecord::Migration[7.1]
  def change
    add_column :scams, :point_1, :string
    add_column :scams, :point_2, :string
    add_column :scams, :point_3, :string
  end
end
