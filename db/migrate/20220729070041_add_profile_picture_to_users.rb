class AddProfilePictureToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_picture, :binary
  end
end
