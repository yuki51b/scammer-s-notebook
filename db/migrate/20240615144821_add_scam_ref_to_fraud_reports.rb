class AddScamRefToFraudReports < ActiveRecord::Migration[7.1]
  def change
    add_reference :fraud_reports, :scam, null: true, foreign_key: true
  end
end
