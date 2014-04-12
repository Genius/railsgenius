module Annotations
  class Index < Perspectives::Base
    param :all_annotations

    nested_collection 'annotations/tiny',
      collection: proc { all_annotations },
      property: :annotations

    property :new_annotation_path
  end
end
