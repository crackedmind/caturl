require 'rails_helper'

RSpec.describe ShortenerController, type: :controller do
  describe 'GET index' do 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'POST create' do
    it "creates new short url and renders json" do
      post :create, params: { url: "http://yandex.ru" }, format: :json
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:created)

      res = JSON.parse(response.body)
      get :show, params: {id: res['short'] }
      expect(response).to redirect_to('http://yandex.ru')
      # follow_redirect!
    end
  end

  describe 'GET show' do
    it "find url and redirect to original" do

    end
  end
end
