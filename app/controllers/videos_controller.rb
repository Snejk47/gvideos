class VideosController < ApplicationController

  before_filter :authenticate_user!, except: [ :index, :show ]

  def index
    if params[:waiting]
      @videos = Video.waiting.page params[:page]
    else
      @videos = Video.main.page params[:page]
    end
  end

  def show
    @video = Video.includes(:comments).find(params[:id])
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    params[:video][:user_id] = current_user.id
    @video = Video.new(params[:video])

    if @video.save
      redirect_to @video, notice: 'Video was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @video = Video.find(params[:id])

    if @video.update_attributes(params[:video])
      redirect_to @video, notice: 'Video was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to videos_url
  end

  def rate
    # refactor this to only ajax response
    if params[:rate].to_i > 0
      rate = Rate.where('user_id = ? and video_id = ?', current_user.id, params[:video_id])
      if rate.count > 0
        render text: 'not_again'
      else
        video = Video.find(params[:video_id])
        video.rates.create(user_id: current_user.id, rate_type: 'normal', rate: params[:rate])
        render text: 'Thanks for your rate.'
      end
    else
      render text: 'not_allowed'
    end
  end
end
