class AddColumnToDramas < ActiveRecord::Migration[5.1]
  def change
    add_column :dramas, :avgrating, :double
  end
end
