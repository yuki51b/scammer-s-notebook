class AddPostsToScamId < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :scam, null: false, foreign_key: true
  end
end
