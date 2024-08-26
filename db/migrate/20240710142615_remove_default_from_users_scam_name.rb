class RemoveDefaultFromUsersScamName < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :users_scam_name, from: '詐欺に注意', to: nil
  end
end
