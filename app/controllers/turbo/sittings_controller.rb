class Turbo::SittingsController < ApplicationController
  def index
    @sittings = Sitting.where(section_id: params[:section_id])
    respond_to do |format|
      format.turbo_stream { }
    end
  end
end
