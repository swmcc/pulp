class Email < ApplicationRecord
  validates :email, presence: true
  validates :app, presence: true
end
