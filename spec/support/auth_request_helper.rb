module AuthRequestHelper
  def http_login
    @headers ||= {}
    username = Rails.application.credentials.http_basic_auth_name
    password = Rails.application.credentials.http_basic_auth_password
    @headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      username, password
    )
  end
end
