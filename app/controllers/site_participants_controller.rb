class SiteParticipantsController < ApplicationController
  # GET /site_participants or /site_participants.json
  def index
    @site = Site.find(params.expect(:site_id))
    @query = @site.site_participants.joins(:participant).merge(Participant.kept).ransack(params[:query])
    @site_participants = @query.result(distinct: true)
                               .page(params[:page])
                               .per(params[:per_page] || 20)
                               .select("site_participants.*, participants.name AS participant_name, participants.study_id AS participant_study_id, participants.category AS participant_category")
                               .includes(participant: :sections)
                               .order("participants.name ASC")
  end

  # DELETE /site_participants/1 or /site_participants/1.json
  def destroy
    @site = Site.find(params.expect(:site_id))
    @site_participant = @site.site_participants.find(params.expect(:id))
    @site_participant.destroy

    respond_to do |format|
      format.html { redirect_to site_site_participants_path(@site), status: :see_other, notice: "Participant was successfully unenrolled." }
      format.json { head :no_content }
    end
  end
end
