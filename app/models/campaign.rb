class Campaign < ApplicationRecord
  validates :identifier, presence: true
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates
end
