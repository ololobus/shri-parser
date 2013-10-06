class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :lector_id
      t.integer :native_id
      t.text :video_url
      t.text :slides_url
      t.string :name
      
      t.timestamps
    end
  end
end
