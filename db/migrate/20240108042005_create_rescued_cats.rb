class CreateRescuedCats < ActiveRecord::Migration[6.1]
  def change
    create_table :rescued_cats do |t|
      t.integer :user_id, null: false
      t.string :name
      t.integer :age, null: false
      t.string :sex, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :is_completion, null: false, default: false
      t.text :vaccine, null: false
      t.boolean :is_castration, null: false, default: false

      t.timestamps
    end
  end
end
