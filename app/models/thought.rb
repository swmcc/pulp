class Thought < ApplicationRecord
  validates :thought, presence: true
  validates :sparked_at, presence: true
end
