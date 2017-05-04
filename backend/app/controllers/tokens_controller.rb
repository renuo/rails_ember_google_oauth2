require 'google/apis/plus_v1'
require 'signet/oauth_2/client'

class TokensController < ApplicationController
  def create
    info = user_info.get_person('me')
    user = User.from_google(info)
    render json: payload(user), status: :ok
  end

  private

  def payload(user)
    { access_token: JsonWebTokenService.encode(user_id: user.id), user: user }
  end

  private

  def user_info
    Google::Apis::PlusV1::PlusService.new.tap do |userinfo|
      userinfo.key = ENV['GOOGLE_KEY']
      userinfo.authorization = auth_client
    end
  end

  def auth_client
    Signet::OAuth2::Client.new(
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://www.googleapis.com/oauth2/v3/token',
      client_id: ENV['GOOGLE_KEY'], client_secret: ENV['GOOGLE_SECRET'],
      scope: 'email profile', redirect_uri: 'http://localhost:4200/oauth2callback'
    ).tap do |client|
      client.code = params['code']
      client.fetch_access_token!
    end
  end
end
