class AnnotationsController < ApplicationController
  perspectives_actions only: :show

  before_action :set_annotation, only: [:show, :edit, :update, :destroy, :tooltip]
  before_action :authenticate_user!, only: [:create, :update]

  def index
    @annotations = Annotation.all
  end

  def tooltip
  end

  def show
    respond_with(perspective('annotations/show', annotation: @annotation))
  end

  def new
    @annotation = Annotation.new
  end

  def edit
  end

  def create
    @annotation = Annotation.new(annotation_params)
    @annotation.created_by = current_user

    respond_to do |format|
      if @annotation.save
        format.html { redirect_to @annotation, notice: 'Annotation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @annotation }
      else
        format.html { render action: 'new' }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @annotation.update(annotation_params)
        format.html { redirect_to @annotation, notice: 'Annotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @annotation.destroy
    respond_to do |format|
      format.html { redirect_to annotations_url }
      format.json { head :no_content }
    end
  end

  private

  def set_annotation
    @annotation = Annotation.find(params[:id])
  end

  def annotation_params
    params.require(:annotation).permit(:body, :talk_id)
  end
end
