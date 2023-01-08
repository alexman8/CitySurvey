require 'rails_helper'

RSpec.describe "Forms", type: :request do
  describe "GET /index" do
    context 'if correct credentials are supplied' do
      it "returns http success" do
        http_login
        get "/forms", headers: @headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'if no credential is supplied' do
      it "returns http unauthorized" do
        get "/forms"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /new" do
    it "returns http success" do
      http_login
      get "/forms/new", headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it 'redirects to the form page' do
      http_login
      post "/forms",
           params:  { form: { title: 'Form', form_fields_attributes: [name: 'Field', type: :text] } },
           headers: @headers
      form = @controller.instance_variable_get(:@form)
      expect(response).to redirect_to(form)
    end
  end

  describe "GET /show" do
    it 'returns http success' do
      http_login
      form = create(:form_with_field)
      get "/forms/#{form.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it 'returns http success' do
      http_login
      form = create(:form_with_field)
      get "/forms/#{form.id}/edit", headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it 'redirects to the form page' do
      form = create(:form_with_field)
      http_login
      patch "/forms/#{form.id}",
            params:  { form: { title: 'Form #1', form_fields_attributes: [name: 'Field #1', type: :text] } },
            headers: @headers
      expect(response).to redirect_to(form)
    end
  end

  describe "PATCH /publish" do
    it 'redirects to the form page' do
      form = create(:form_with_field)
      http_login
      patch "/forms/#{form.id}/publish", headers: @headers
      expect(response).to redirect_to(form)
    end
  end

  describe "GET /view" do
    before(:all) do
      @form = create(:form_with_field)
    end

    context 'if the supplied token does not match the one of the form' do
      it 'redirects to the error page' do
        get "/forms/#{@form.id}/view?token=12345"
        expect(response).to redirect_to(error_url)
      end
    end

    context 'if the supplied token does match the one of the form' do
      it 'returns http success' do
        get "/forms/#{@form.id}/view?token=#{@form.token}"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE /destroy" do
    it 'redirects to the forms page' do
      form = create(:form_with_field)
      http_login
      delete "/forms/#{form.id}", headers: @headers
      expect(response).to redirect_to(forms_url)
    end
  end
end
