class AddColumnsToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :urine, :string
    add_column :diaries, :feces, :string
    add_column :diaries, :hydration_amount, :string
    add_column :diaries, :food, :string
    add_column :diaries, :vomiting, :string
    add_column :diaries, :weather, :integer
    add_column :diaries, :temperature, :float
    
  end
end
