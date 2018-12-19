class AddColumnToMoviereps < ActiveRecord::Migration[5.1]
  def change
    add_column :moviereps, :movie_id, :integer
  end
end
