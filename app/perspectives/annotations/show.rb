module Annotations
  class Show < Perspectives::Base
    param :annotation
    param :embedded, allow_nil: true

    delegate_property :id, :referent, to: :annotation

    delegate :talk, to: :annotation
    delegate_property :title, to: :talk, prefix: true
    property(:talk_href) { talk_path(talk) }

    property(:body) { annotation.body_as_html }

    property :annotations_path

    property(:edit_href) { expanded_annotation_edit_talk_path(talk, annotation) }
    property(:incremental_href) { edit_annotation_path(annotation, embedded: true) }
  end
end
