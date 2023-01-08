require 'rails_helper'

RSpec.describe "FormSubmissions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      form = create(:form_with_field)
      http_login
      get "/forms/#{form.id}/form_submissions", headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    before(:all) do
      @form = create(:form_with_field)
    end

    context 'if the supplied token does not match the one of the form' do
      it 'redirects to the error page' do
        post "/form_submissions", params: {form_submission: {form_id: @form.id, token: '12345'}}
        expect(response).to redirect_to(error_url)
      end
    end

    context 'if the supplied token does match the one of the form' do
      it 'redirects to the form submission confirmation page' do
        post "/form_submissions", params: {form_submission: {form_id: @form.id, token: @form.token}}
        expect(response).to redirect_to(form_submission_url(@controller.instance_variable_get(:@form_submission),
                                                            token: @form.token))
      end
    end
  end

  describe "GET /show" do
    before(:all) do
      @form_submission = create(:form_submission)
    end

    context 'if the supplied token does not match the one of the form' do
      it 'redirects to the error page' do
        get "/form_submissions/#{@form_submission.id}?token=12345"
        expect(response).to redirect_to(error_url)
      end
    end

    context 'if the supplied token does match the one of the form' do
      it 'returns http success' do
        get "/form_submissions/#{@form_submission.id}?token=#{@form_submission.form.token}"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
