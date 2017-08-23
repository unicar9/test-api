class ParanuaraController < ApplicationController
  def company
    company = Company.find_by(company: params["name"].upcase)
    @employees = company.people

    render :json => {
      number_of_employees: @employees.length,
      employees: @employees.as_json(:only => [:name, :age])
      }
  end

  def people

    person1 = Person.find_by(index:params['index1'])
    person2 = Person.find_by(index:params['index2'])

    common_indexes = eval(person1.friends).map!{|f| f["index"]} & eval(person2.friends).map!{|f| f["index"]}

    common_friends = Person.where(index: common_indexes, has_died: false, eyeColor: "brown")

    render :json => {
      person1: person1.as_json(:only => [:index, :name, :age, :address, :phone]),
      person2: person2.as_json(:only => [:index, :name, :age, :address, :phone]),
      common_friends: common_friends.as_json(:only => [:index, :name, :age, :address, :phone, :eyeColor, :has_died])
     }
  end

  def person
    person = Person.find_by(index: params['index'])
    foods = person.foods
    foods = foods.group_by{|f| f.category}

    render :json => {
      name: person.name,
      age: person.age,
      fruits: foods['fruits'].nil? ? [] : foods['fruits'].pluck('name'),
      vegetables: foods['vegetables'].nil? ? [] : foods['vegetables'].pluck('name')
    }
  end

end
