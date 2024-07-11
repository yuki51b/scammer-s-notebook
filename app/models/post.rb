class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65_535 }
    validates :users_scam_name, presence: true, length: { maximum: 255 }

    belongs_to :user
    belongs_to :scam, optional: true
end
