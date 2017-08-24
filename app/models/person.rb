class Person < ApplicationRecord
  belongs_to :company, :foreign_key => 'company_index', :primary_key => 'index', optional: true
  has_and_belongs_to_many :foods

  has_and_belongs_to_many :friends,
                          class_name: 'Person',
                          join_table: :friends,
                          foreign_key: :person_id,
                          association_foreign_key: :friend_id,
                          uniq: true
end
