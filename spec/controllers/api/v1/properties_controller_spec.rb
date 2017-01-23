require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  describe "POST #index" do
    before do
      @user = create(:user)
      @property = create(:property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end
    end
end

  describe "DELETE #index" do
    before do
      @user     = create(:user)
      @property = create(:property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end
    end
  end
end
