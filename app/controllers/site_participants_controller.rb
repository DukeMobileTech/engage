class SiteParticipantsController < ApplicationController
  # GET /site_participants or /site_participants.json
  def index
    @site = Site.find(params.expect(:site_id))
    @query = @site.site_participants.joins(:participant).ransack(params[:query])
    @site_participants = @query.result(distinct: true)
                               .page(params[:page])
                               .per(params[:per_page] || 20)
                               .select("site_participants.*, participants.name AS participant_name, participants.study_id AS participant_study_id, participants.category AS participant_category")
                               .includes(participant: :sections)
                               .order("participants.name ASC")
  end
end
