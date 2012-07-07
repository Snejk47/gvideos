class ApplicationController < ActionController::Base
  protect_from_forgery

  def count_main_videos
    Video.where("accepted = ?", true).count
  end

  def count_waiting_videos
    Video.where("accepted = ?", false).count
  end

  helper_method :count_main_videos, :count_waiting_videos

end
