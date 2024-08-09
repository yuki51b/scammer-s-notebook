class CreateScams < ActiveRecord::Migration[7.0]
  def change
    create_table :scams do |t|
      t.string :name, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
