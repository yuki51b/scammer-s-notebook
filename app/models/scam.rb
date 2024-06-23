class Scam < ApplicationRecord
    has_many :fraud_report
    has_many :posts
end
