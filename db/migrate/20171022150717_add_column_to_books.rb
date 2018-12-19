class AddColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :avgrating, :double
  end
end
