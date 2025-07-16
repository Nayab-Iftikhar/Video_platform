class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :integer, null: false, default: 0
  end
end
