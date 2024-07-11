class Scam < ApplicationRecord
	has_many :fraud_report
	has_many :posts

	def self.ransackable_attributes(auth_object = nil)
		["name"]
	end
end
