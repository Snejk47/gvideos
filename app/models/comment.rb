class Comment < ActiveRecord::Base
  attr_accessible :video_id, :content, :user_id

  belongs_to :user
  belongs_to :video

  default_scope order: 'created_at DESC'
end
