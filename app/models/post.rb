class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :users_scam_name, presence: true, length: { maximum: 255 }

  has_many :likes, dependent: :destroy

  belongs_to :user
  belongs_to :scam, optional: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[title users_scam_name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user scam]
  end
end
