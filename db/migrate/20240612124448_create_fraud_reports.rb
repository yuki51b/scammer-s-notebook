class CreateFraudReports < ActiveRecord::Migration[7.1]
  def change
    create_table :fraud_reports do |t|
      t.string :contact_method, null: false
      t.string :contact_content, null: false
      t.string :information, null: false
      t.string :urgent_action, null: false
      t.string :payment_method, null: false
      t.string :company_info, null: false
      t.text :additional_details
      t.string :respond

      t.timestamps
    end
  end
end
