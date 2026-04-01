class UserSitesController < ApplicationController
  before_action :set_site

  def index
    @user_sites = @site.user_sites.includes(:user)
  end

  private
    def set_site
      @site = Site.find(params[:site_id])
    end
end
