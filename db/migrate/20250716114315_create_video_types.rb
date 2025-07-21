class CreateVideoTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :video_types do |t|
      t.string :name, null: false
      t.decimal :price, null: false
      t.string :format, null: false
      t.string :descrption, null: false
      t.string :video_url, null: false

      t.timestamps
    end
  end
end
