class CreateFoodsPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :foods_people do |t|
      t.integer :food_id
      t.integer :person_id
    end
  end
end
