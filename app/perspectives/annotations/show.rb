module Annotations
  class Show < Perspectives::Base
    param :annotation
    delegate_property :referent, to: :annotation

    delegate :talk, to: :annotation
    delegate_property :title, to: :talk, prefix: true
    property(:talk_href) { talks_path(talk) }

    property(:body) { annotation.body_as_html }

    property :annotations_path

    property(:edit) { edit_annotation_path(annotation) }
  end
end
