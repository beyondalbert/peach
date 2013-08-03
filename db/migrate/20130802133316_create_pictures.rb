class CreatePictures < ActiveRecord::Migration
  def up
	create_table :pictures do |t|
	  t.integer :user_id
	  t.string :name
	  t.string :path
	  t.integer :size
	  t.string :note
	  t.float :logitude
	  t.float :latitude
	  t.string :location
	  t.string :geohash
	  t.timestamps
	 end
  end

  def down
	drop_table :pictures
  end
end
