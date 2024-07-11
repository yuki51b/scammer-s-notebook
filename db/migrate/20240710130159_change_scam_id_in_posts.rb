class ChangeScamIdInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :scam_id, true
  end
end
