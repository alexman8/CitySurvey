class ApplicationController < ActionController::Base
  private

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == Rails.application.credentials.http_basic_auth_name &&
        password == Rails.application.credentials.http_basic_auth_password
    end
  end
end
