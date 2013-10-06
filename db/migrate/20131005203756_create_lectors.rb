class CreateLectors < ActiveRecord::Migration
  def change
    create_table :lectors do |t|
      t.string :name
      t.string :photo_url
      t.text :about
      t.integer :native_id
      
      t.timestamps
    end
  end
end
