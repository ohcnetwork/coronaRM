class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_USER"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"], if: -> { ENV['RAILS_ENV'] == 'production' }
end
