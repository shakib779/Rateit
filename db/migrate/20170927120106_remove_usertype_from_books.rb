class RemoveUsertypeFromBooks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :books, :usertype
  end
end
