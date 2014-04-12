class AnnotationsController < ApplicationController
  perspectives_actions

  before_action :set_annotation, only: [:show, :edit, :update, :destroy, :tooltip]
  before_action :authenticate_user!, only: [:create, :update]

  def index
    respond_with(perspective('annotations/index', all_annotations: Annotation.all))
  end

  def show
    respond_with(perspective('annotations/show', annotation: @annotation))
  end

  def new
    respond_with(perspective('annotations/new', annotation: Annotation.new))
  end

  def edit
    respond_with(perspective('annotations/edit', annotation: @annotation))
  end

  def create
    annotation = Annotation.new(annotation_params)
    annotation.created_by = current_user

    if annotation.save
      respond_to do |format|
        format.html { redirect_to annotation, notice: 'Annotation was successfully created.' }
        format.json { render json: perspective('annotations/show', annotation: annotation) }
      end
    else
      respond_with(perspective('annotations/new', annotation: annotation))
    end
  end

  def update
    if @annotation.update(annotation_params)
      respond_to do |format|
        format.html { redirect_to @annotation, notice: 'Annotation was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_with(perspective('annotations/edit', annotation: @annotation))
    end
  end

  def destroy
    @annotation.destroy
    respond_to do |format|
      format.html { redirect_to annotations_url, notice: "Destroyed Annotation" }
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
