class AddPhotoToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :photo, :string
  end
end
