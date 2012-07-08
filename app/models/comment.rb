class Comment < ActiveRecord::Base
  attr_accessible :video_id, :content, :user_id
  validates :content, length: { minimum: 10, maximum: 200 }

  belongs_to :user
  belongs_to :video

  default_scope order: 'created_at DESC'
end
