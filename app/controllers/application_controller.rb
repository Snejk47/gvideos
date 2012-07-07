class ApplicationController < ActionController::Base
  protect_from_forgery

  def count_main_videos
    Video.where("accepted = ?", true).count
  end

  def count_waiting_videos
    Video.where("accepted = ?", false).count
  end

  def get_user_video_rate(rates)
    r = rates.where('user_id = ?', current_user.id)
    if r.count > 0
      r.first.rate
    else
      0
    end
  end

  helper_method :count_main_videos, :count_waiting_videos, :get_user_video_rate

end
