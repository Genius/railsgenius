class Annotations::Form < Perspectives::Base
  param :annotation
  delegate_property :body, to: :annotation

  nested 'shared/errors', object: :annotation

  property(:submit_method) { annotation.persisted? && 'patch' }
  property(:submit_to) { annotation.persisted? ? talk_annotation_path(annotation.talk, annotation) : talk_annotations_path(annotation.talk) }

  property(:talks) do
    Talk.all.map { |t| {title: t.title, id: t.id, selected: annotation.talk_id == t.id} }
  end
end
