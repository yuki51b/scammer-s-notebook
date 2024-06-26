class AddFraudRepotsToWhoPerson < ActiveRecord::Migration[7.1]
  def change
    add_column :fraud_reports, :who_person, :string, null: false, default: "怪しい人"
  end
end
