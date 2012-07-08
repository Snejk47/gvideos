class Video < ActiveRecord::Base
  attr_accessible :user_id, :accepted, :description, :title, :youtube_url

  validates :title, length: { minimum: 5, maximm: 30 }
  validates :description, length: { minimum: 3, maximm: 100 }
  validates :youtube_url, format: { with: /v=([\w\d_-]+)&?/ }


  belongs_to :user
  has_many :comments
  has_many :rates

  scope :main, where("accepted = ?", true).order("created_at DESC").includes(:rates)
  scope :waiting, where("accepted = ?", false).order("created_at DESC").includes(:rates)

  def embeded_code
    v = get_v
    "<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/#{v}?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
  end

  def get_thumbnail
    v = get_v
    "http://img.youtube.com/vi/#{v}/2.jpg"
  end

  def get_user_video_rate(id)
     r = rates.where('user_id = ?', id)
     if r.count > 0
       r.first.rate
     else
       0
     end
  end

  def calculate_rate
    c = rates.count
    if c > 0
      sum = 0 # variable for storing actual sum of rates
      rates.each do |rate|
        sum += rate.rate if !rate.rate.nil? 
      end
      sum / c
    else
      0
    end
  end

private
  
  def get_v
    youtube_url.scan(/v=([\w\d_-]+)&?/)[0][0]
  end

end
