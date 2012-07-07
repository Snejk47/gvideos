class ChangeTypeInRates < ActiveRecord::Migration
  def change
    rename_column :rates, :type, :rate_type
  end
end
