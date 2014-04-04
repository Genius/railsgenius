module Talks
  class Index < Perspectives::Base
    param :all_talks

    nested_collection 'talks/tiny',
      collection: proc { all_talks },
      property: :talks

    property :new_talk_path
  end
end
