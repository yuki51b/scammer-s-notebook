class AddPostsToUsersScamName < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :users_scam_name, :text, null: false, default: '詐欺に注意'
  end
end
