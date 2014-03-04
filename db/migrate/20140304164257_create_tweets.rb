class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :name
      t.text :content
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
