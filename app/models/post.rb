class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65_535 }

    belongs_to :user
end
