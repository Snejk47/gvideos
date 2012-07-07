class AddVideoidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :video_id, :integer
  end
end
