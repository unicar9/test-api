require 'rails_helper'

RSpec.describe ParanuaraController, type: :controller do

  let(:name) {"MAINELAND"}

  describe "GET /company/:name" do
    before { get :company, params: {name: name} }

    context 'when the company exists' do
      it 'returns the employees of the company' do
        company = Company.find_by(company: "MAINELAND")
        res = JSON.parse( response.body )
        expect(res).not_to be_empty
        expect(res['number_of_employees']).to eq(company.people.length)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the company does not exist' do
      let(:name) {"MAINE"}

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
