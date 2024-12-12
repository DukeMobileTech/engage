class SiteParticipantsController < ApplicationController
  # GET /site_participants or /site_participants.json
  def index
    @site = Site.find(params.expect(:site_id))
    @site_participants = @site.site_participants
  end
end
