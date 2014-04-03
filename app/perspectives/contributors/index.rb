module Contributors
  class Index < LinearPerspective::Base
    param :talk
    delegate_property :title, to: :talk
    property(:path) { talk_path(id: talk.id) }

    cache { talk }

    nested_collection '/users/show',
      collection: proc { talk.contributors },
      property: :contributors
  end
end
