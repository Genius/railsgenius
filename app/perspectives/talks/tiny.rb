module Talks
  class Tiny < Perspectives::Base
    include Users::Helpers

    param :talk
    delegate_property :title, to: :talk

    property(:path) { talk_path(talk) }
    property(:edit_path) { edit_talk_path(talk) }
    property(:speaker_name) { display_name(talk.speaker) }
  end
end
