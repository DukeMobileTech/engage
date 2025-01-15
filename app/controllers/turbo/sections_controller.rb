class Turbo::SectionsController < ApplicationController
  def index
    @sections = Section.where(site_id: params[:site_id])
    respond_to do |format|
      format.turbo_stream { }
    end
  end
end
