class Rate < ActiveRecord::Base
  attr_accessible :rate, :rate_type, :user_id, :video_id

  belongs_to :user
  belongs_to :video
end
