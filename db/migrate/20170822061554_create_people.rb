class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.integer :age
      t.integer :index
      t.boolean :has_died
      t.string :eyeColor
      t.string :gender
      t.string :email
      t.string :_id
      t.string :guid
      t.string :phone
      t.string :address
      t.text :about
      t.string :greeting
      t.string :registered
      t.string :balance
      t.string :picture
      t.integer :company_index

      t.timestamps
    end
  end
end
