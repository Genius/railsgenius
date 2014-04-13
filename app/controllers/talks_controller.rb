class TalksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  perspectives_actions

  def index
    respond_with(perspective('talks/index', all_talks: Talk.all))
  end

  def show
    expanded_annotation = @talk.annotations.find(params[:annotation_id]) if params[:annotation_id]

    respond_with(perspective(
      'talks/show',
      talk: @talk,
      expanded_annotation: expanded_annotation))
  end

  def new
    respond_with(perspective('talks/new', talk: Talk.new))
  end

  def edit
    respond_with(perspective('talks/edit', talk: @talk))
  end

  def create
    talk = Talk.new(talk_params)
    talk.created_by = current_user

    if talk.save
      respond_to do |format|
        format.html { redirect_to talk, notice: 'Talk was successfully created.' }
        format.json { render json: perspective('talks/show', talk: talk) }
      end
    else
      respond_with(perspective('talks/new', talk: talk))
    end
  end

  def update
    if @talk.update(talk_params)
      respond_to do |format|
        format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
        format.json { render json: perspective('talks/show', talk: @talk) }
      end
    else
      respond_with(perspective('talks/edit', talk: @talk))
    end
  end

  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to talks_url, notice: "Destroyed Talk" }
      format.json { head :no_content }
    end
  end

  private

  def authorize!
    authorize_access!(current_user == @talk.created_by || current_user.admin?)
  end

  def set_talk
    @talk = Talk.find(params[:id])
  end

  def talk_params
    params.require(:talk).permit(:title, :abstract, :speaker_id)
  end
end
