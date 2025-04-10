class SiteParticipantsController < ApplicationController
  # GET /site_participants or /site_participants.json
  def index
    @site = Site.find(params.expect(:site_id))
    @query = @site.site_participants.ransack(params[:query])
    @site_participants = @query.result(distinct: true)
  end
end
