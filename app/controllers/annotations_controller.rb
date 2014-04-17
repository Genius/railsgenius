class AnnotationsController < ApplicationController
  perspectives_actions
  wrapped_with 'talks/show', only: [:show, :edit]

  before_action :set_annotation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update]

  def index
    respond_with(perspective('annotations/index', all_annotations: annotations_scope.all))
  end

  def show
    respond_with(perspective('annotations/show', annotation: @annotation))
  end

  def new
    respond_with(perspective('annotations/new', annotation: annotations_scope.new))
  end

  def edit
    respond_with(perspective('annotations/edit', annotation: @annotation))
  end

  def create
    annotation = annotations_scope.new(annotation_params)
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

  def annotations_scope
    if params[:talk_id]
      Talk.find(params[:talk_id]).annotations
    else
      Annotation
    end
  end

  def set_annotation
    @annotation = annotations_scope.find(params[:id])
  end

  def annotation_params
    params.require(:annotation).permit(:body, :talk_id)
  end
end
