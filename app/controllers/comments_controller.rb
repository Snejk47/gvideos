class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

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
      render action: "new"
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to comments_url
  end
end
