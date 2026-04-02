class UserSitesController < ApplicationController
  before_action :set_site

  def index
    @users = @site.site_users
  end

  private
    def set_site
      @site = Site.find(params[:site_id])
    end
end
