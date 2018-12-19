class AddColumnToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :avgrating, :double
  end
end
