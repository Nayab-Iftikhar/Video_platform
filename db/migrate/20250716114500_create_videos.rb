class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.references :project, null: false, foreign_key: true
      t.references :video_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
