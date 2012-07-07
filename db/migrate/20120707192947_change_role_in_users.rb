class ChangeRoleInUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, default: 'user', null: false
  end
end
