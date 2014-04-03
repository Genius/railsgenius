class ContributorsController < ApplicationController
  def index
    @talk = Talk.find(params[:id])
    @contributors = @talk.contributors
  end
end
