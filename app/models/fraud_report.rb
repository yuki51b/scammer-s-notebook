class FraudReport < ApplicationRecord
    belongs_to :scam

    validates :contact_method, presence: true, length: { maximum: 255 }
    validates :contact_content, presence: true, length: { maximum: 255 }
    validates :information, presence: true, length: { maximum: 255 }
    validates :urgent_action, presence: true, length: { maximum: 255}
    validates :payment_method, presence: true, length: { maximum: 255}
    validates :company_info, presence: true, length: { maximum: 255}
    validates :who_person, presence: true, length: { maximum: 255 }
    validates :additional_details, length: { maximum: 255}
end
