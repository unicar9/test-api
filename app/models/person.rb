class Person < ApplicationRecord
  belongs_to :company, :foreign_key => 'company_index', :primary_key => 'index', optional: true
  has_and_belongs_to_many :foods
end
