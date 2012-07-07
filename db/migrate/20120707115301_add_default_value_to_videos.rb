class AddDefaultValueToVideos < ActiveRecord::Migration
  def change
    change_column :videos, :accepted, :boolean, default: false, null: false
  end
end
