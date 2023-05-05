class Commit < ApplicationRecord
  validates :repo_name, presence: true
  validates :sha, presence: true
  validates :message, presence: true
  validates :commit_date, presence: true
end
