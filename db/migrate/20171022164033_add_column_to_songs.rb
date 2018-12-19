class AddColumnToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :avgrating, :double
  end
end
