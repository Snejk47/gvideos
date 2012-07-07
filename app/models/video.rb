class Video < ActiveRecord::Base
  attr_accessible :user_id, :accepted, :description, :title, :youtube_url

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

  def calculate_rate(v)
    c = v.rates.count
    if c > 0
      sum = 0 # variable for storing actual sum of rates
      v.rates.each do |rate|
        sum += rate.rate
      end
      sum / v.rates.count
    else
      0
    end
  end

private
  
  def get_v
    youtube_url.scan(/v=([\w\d]+)&?/)[0][0]
  end

end
