class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :user_id
      t.integer :video_id
      t.string :type
      t.integer :rate

      t.timestamps
    end
  end
end
