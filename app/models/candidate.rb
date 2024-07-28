class Candidate < ApplicationRecord
  validates :name, presence: true
  belongs_to :campaign
  has_many :votes, dependent: :destroy
end
