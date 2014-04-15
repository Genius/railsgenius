class Annotations::Edit < Perspectives::Base
  param :annotation
  param :embedded, allow_nil: true
  delegate_property :id, to: :annotation

  property(:path) do
    if embedded
      expanded_annotation_talk_path(annotation.talk, annotation)
    else
      incremental_href
    end
  end

  property(:incremental_href) do
    annotation_path(annotation, embedded: true)
  end

  property :annotations_path

  nested 'form', annotation: :annotation
end
