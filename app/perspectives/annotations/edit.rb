class Annotations::Edit < Perspectives::Base
  param :annotation
  delegate_property :id, to: :annotation

  property(:path) do
    talk_annotation_path(annotation.talk, annotation)
  end

  nested 'form', annotation: :annotation
end
