class Post < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true

  belongs_to :user

  has_many :tags
end
