class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.string :image_id
      t.text :remark
      t.integer :user_id

      t.timestamps
    end
  end
end
