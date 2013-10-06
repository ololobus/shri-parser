class CreateLectorsLectures < ActiveRecord::Migration
  def change
    create_table :lectors_lectures do |t|
      t.string :name
      t.integer :lector_id
      t.string :url
      
      t.timestamps
    end
  end
end
