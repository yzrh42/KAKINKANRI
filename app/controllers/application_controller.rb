class ApplicationController < ActionController::Base
    add_flash_types :success, :info, :warning, :danger
    before_action :authenticate_user!
    protect_from_forgery with: :null_session
end
