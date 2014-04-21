module Annotations
  class Show < Perspectives::Base
    param :annotation

    cache { annotation }

    delegate_property :id, :referent, to: :annotation

    delegate :talk, to: :annotation
    delegate_property :title, to: :talk, prefix: true
    property(:talk_href) { talk_path(talk) }

    property(:body) { annotation.body_as_html }

    property(:edit) do
      annotation.created_by == current_user || current_user.try(:admin?)
    end

    property(:destroy) { edit }

    property(:edit_href) { edit_talk_annotation_path(talk, annotation) }
    property(:annotation_href) { talk_annotation_path(talk, annotation) }
    property(:perspectives_target) { '#annotation-tooltip' }
  end
end
