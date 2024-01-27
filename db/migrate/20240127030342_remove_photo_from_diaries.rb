class RemovePhotoFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :diaries, :photo, :string
  end
end
