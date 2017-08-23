class Company < ApplicationRecord
  has_many :people, :foreign_key => 'company_index', :primary_key => 'index'
end
