class Annotations::Edit < Perspectives::Base
  param :annotation

  property(:path) { annotation_path(annotation) }
  property :annotations_path

  nested 'form', annotation: :annotation
end
