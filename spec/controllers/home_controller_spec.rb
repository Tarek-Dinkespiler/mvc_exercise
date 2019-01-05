# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #landing_page" do
    it "returns http success" do
      get :landing_page
      expect(response).to have_http_status(:success)
    end
  end
end
