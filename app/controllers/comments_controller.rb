class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]
  authorize_resource

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    params[:comment][:video_id] = params[:video_id]
    params[:comment][:user_id] = current_user.id
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to video_path(params[:video_id]), notice: 'Comment was successfully created.'
    else
      @video = Video.find(params[:video_id])
      render template: 'videos/show' 
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to video_path(params[:video_id]), notice: 'Comment was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to video_path(params[:video_id]), notice: 'Comment was successfully deleted.'
  end
end
