class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :footage_url, null: false
      t.string :status, default: "pending", null: false
      t.datetime :paid_at
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :project_manager, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
