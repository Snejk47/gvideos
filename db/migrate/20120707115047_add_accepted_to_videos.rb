class AddAcceptedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :accepted, :boolean
  end
end
