require 'rails_helper'

RSpec.describe ParanuaraController, type: :controller do

  # initialize testing data
  before do
    Company.create index: 0, company: "A"
    p1 = Person.create index:1, name: 'Tom', age: 45, company_index: 0, address: "999 Cool Street", phone: "01-234-5678-9"
    f1 = Food.create name:"f1", category: "fruits"
    f2 = Food.create name:"f2", category: "fruits"
    f3 = Food.create name:"f3", category: "vegetables"
    f4 = Food.create name:"f4", category: "vegetables"
    p1.foods << f1 << f2 << f3 << f4
    p2 = Person.create index:2, name: 'Bob', age: 35, company_index: 0
    p3 = Person.create index:3, name: 'Jerry', age: 35, company_index: 0, has_died: false, eyeColor: "brown"
    p4 = Person.create index:4, name: 'Max', age: 58, company_index: 0, has_died: false, eyeColor: "brown"
    p1.friends << p3 << p4
    p2.friends << p3 << p4
  end

  describe "GET /company/:name" do

    let(:name) {"A"}
    before { get :company, params: {name: name} }

    context 'when the company exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the employees of the company' do
        company = Company.find_by(company: "A")
        res = JSON.parse( response.body )
        expect(res).not_to be_empty
        expect(res['number_of_employees']).to eq(company.people.length)
      end
    end

    context 'when the company does not exist' do
      let(:name) {"B"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        res = JSON.parse( response.body )
        expect(res["message"]).to match("Company doesn't exist")
      end
    end
  end # /company/:name


  describe "GET /people?index1=[integer]&index2=[integer]" do
    let(:index1){1}
    let(:index2){2}

    before { get :people, params: {index1: index1, index2: index2} }

    context 'when the two people exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns info and common friends of them' do
        res = JSON.parse( response.body )
        expect(res).not_to be_empty
        expect(res['person1']).not_to be_empty
        expect(res['person2']).not_to be_empty
        expect(res['common_friends'].length).to eq(2)
      end
    end

    context 'when person does not exists or missing indexes' do
      let(:index1){1}
      let(:index2){9999}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        res = JSON.parse( response.body )
        expect(res["message"]).to match("Person doesn't exist or missing indexes")
      end
    end
  end # GET /people?index1=[integer]&index2=[integer]


  describe "GET /person/:index" do
    let(:index){1}
    before { get :person, params: {index: index} }

    context 'when the person exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the info of this person' do
        res = JSON.parse( response.body )
        expect(res).not_to be_empty
        expect(res['fruits'].length).to eq 2
        expect(res['vegetables'].length).to eq 2
      end
    end

    context 'when the person does not exist' do
      let(:index) {9999}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        res = JSON.parse( response.body )
        expect(res["message"]).to match("Person doesn't exist")
      end
    end
  end

end
