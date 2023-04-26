class User < ApplicationRecord

  enum :role, %i[user admin], suffix: true, default: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "Stephen McCullough"
  end
end
