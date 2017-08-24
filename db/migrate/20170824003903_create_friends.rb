class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :person_id
      t.integer :friend_id
    end

    add_index(:friends, [:person_id, :friend_id], :unique => true)
    add_index(:friends, [:friend_id, :person_id], :unique => true)
  end
end
