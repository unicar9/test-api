require 'rails_helper'

RSpec.describe ParanuaraController, type: :controller do

  # initialize testing data
  before do
    Company.create index: 0, company: "A"
    Person.create name: 'Tom', age: 45, company_index: 0
    Person.create name: 'Bob', age: 35, company_index: 0
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
    before { get :company, params: {index1: index1, index2: index2} }

    context 'when the company exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns' do
        company = Company.find_by(company: "A")
        res = JSON.parse( response.body )
        expect(res).not_to be_empty
        expect(res['number_of_employees']).to eq(company.people.length)
      end
    end

    context 'when ' do
      let(:name) {"B"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        res = JSON.parse( response.body )
        expect(res["message"]).to match("Company doesn't exist")
      end
    end
  end # GET /people?index1=[integer]&index2=[integer]


  describe "GET /person/:index" do

    before { get :person, params: {index: index} }

    context 'when the person exists' do
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

    context 'when the person does not exist' do
      let(:name) {"B"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        res = JSON.parse( response.body )
        expect(res["message"]).to match("Company doesn't exist")
      end
    end
  end

end
