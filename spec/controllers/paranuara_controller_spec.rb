require 'rails_helper'

RSpec.describe ParanuaraController, type: :controller do

  describe "GET #company" do
    it "returns a success response" do
      peach = Peach.create! valid_attributes
      get :company, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

end
