class CreateUsers < ActiveRecord::Migration
  def up
	create_table :users do |t|
	  t.string :email, :null => false
	  t.text :password_hash, :null => false
	  t.text :password_salt, :null => false
	  t.string :token   
	  t.float :longitude
	  t.float :latitude
	  t.string :location
	  t.string :geohash
	  t.timestamps
	end
  end

  def down
	drop_table :users
  end
end
