class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :contact, :privacy_policy, :terms_of_service]
  def top; end

  def contact; end
  def privacy_policy; end
  def terms_of_service; end
end
