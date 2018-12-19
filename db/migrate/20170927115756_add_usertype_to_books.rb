class AddUsertypeToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :usertype, :integer
  end
end
