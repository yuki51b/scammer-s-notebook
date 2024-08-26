class Scam < ApplicationRecord
  has_many :fraud_report, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :point_1, presence: true, length: { maximum: 255 }
  validates :point_2, presence: true, length: { maximum: 255 }
  validates :point_3, presence: true, length: { maximum: 255 }
  validates :scam_strategy, presence: true, length: { maximum: 1000 }

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
