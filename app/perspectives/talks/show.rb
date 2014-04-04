module Talks
  class Show < Perspectives::Base
    param :talk

    property(:path) { talk_path(talk) }
    property(:edit_path) { edit_talk_path(talk) }

    property(:destroy) do
      link_to 'Destroy', talk, method: :delete, data: { confirm: 'Are you sure?' }
    end
  end
end
