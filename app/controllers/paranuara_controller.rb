class ParanuaraController < ApplicationController
  def company
    company = Company.find_by(company: params["name"].upcase)

    if company
      @employees = company.people
      render :json => {
        number_of_employees: @employees.length,
        employees: @employees.as_json(:only => [:name, :age])
        }
    else
      render :json => {status: "error", code: 404, message: "Company doesn't exist"}, :status => 404
    end


  end

  def people

    person1 = Person.find_by(index:params['index1'])
    person2 = Person.find_by(index:params['index2'])

    if person1 && person2 # if person1 and person2 exist

      # find their common friends with eyecolor = 'brown' and still living
      common_friends = person1.friends & person2.friends.where(has_died: false, eyeColor: "brown")

      render :json => {
        person1: person1.as_json(:only => [:index, :name, :age, :address, :phone]),
        person2: person2.as_json(:only => [:index, :name, :age, :address, :phone]),
        common_friends: common_friends.as_json(:only => [:index, :name, :age, :address, :phone, :eyeColor, :has_died])
       }
    else
      render :json => {status: "error", code: 404, message: "Person doesn't exist or missing indexes"}, :status => 404
    end


  end

  def person
    person = Person.find_by(index: params['index'])

    if person
      foods = person.foods
      foods = foods.group_by{|f| f.category}

      render :json => {
        name: person.name,
        age: person.age,
        fruits: foods['fruits'].nil? ? [] : foods['fruits'].pluck('name'),
        vegetables: foods['vegetables'].nil? ? [] : foods['vegetables'].pluck('name')
      }
    else
      render :json => {status: "error", code: 404, message: "Person doesn't exist"}, :status => 404
    end

  end

end
