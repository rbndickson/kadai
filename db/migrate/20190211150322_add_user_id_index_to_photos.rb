class AddUserIdIndexToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_index :photos, :user_id
  end
end
