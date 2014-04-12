class Annotations::Tiny < Perspectives::Base
  param :annotation
  delegate_property :referent, :truncated_body, to: :annotation
  property(:path) { annotation_path(annotation) }

  delegate :talk, to: :annotation

  property(:talk_href) { talk_path(talk) }
  property(:edit) { edit_annotation_path(annotation) }
end
