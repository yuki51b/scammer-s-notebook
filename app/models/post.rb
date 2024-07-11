class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }
    validates :body, presence: true, length: { maximum: 65_535 }
    validates :users_scam_name, presence: true, length: { maximum: 255 }

    belongs_to :user
    belongs_to :scam, optional: true

    def self.ransackable_attributes(auth_object = nil)
		["title", "users_scam_name"]
	end

    def self.ransackable_associations(auth_object = nil)
        ["user", "scam"]
    end
end
