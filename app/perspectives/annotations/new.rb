class Annotations::New < Perspectives::Base
  param :annotation

  nested 'form', annotation: :annotation
end
