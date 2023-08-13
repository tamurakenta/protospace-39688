class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :protospace

  validates :content, presence: true
end
