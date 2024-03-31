class StaticPagesController < ApplicationController
  skip_before_action
  def top; end

  def contact; end
  def privacy_policy; end
  def terms_of_service; end
end
