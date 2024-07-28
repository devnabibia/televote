class Vote < ApplicationRecord
  belongs_to :candidate
  delegate :campaign, to: :candidate
end
