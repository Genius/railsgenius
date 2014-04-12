class Annotations::New < Perspectives::Base
  param :annotation

  property :annotations_path

  nested 'form', annotation: :annotation
end
