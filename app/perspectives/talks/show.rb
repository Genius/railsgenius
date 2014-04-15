module Talks
  class Show < Perspectives::Base
    include Users::Helpers

    param :talk
    param :expanded_annotation, :edit_annotation, allow_nil: true
    property(:expanded_annotation?) { !!expanded_annotation }
    delegate_property :title, to: :talk

    property :talks_path

    property(:path) { talk_path(talk) }

    property(:edit_path) { edit_talk_path(talk) }

    property(:speaker_name) { display_name(talk.speaker) }
    property(:speaker_path) { user_path(talk.speaker) }

    property(:abstract) { talk.abstract_as_html }

    property(:speaker_avatar) { avatar(talk.speaker, size: 50) }

    property(:edit) do
      talk.created_by == current_user || current_user.try(:admin?)
    end

    property(:create_annotation_path) do
      talk_annotations_path(talk_id: talk.id)
    end

    def annotation
      return unless expanded_annotation?

      if edit_annotation
        Annotations::Edit.new(context, annotation: expanded_annotation)
      else
        Annotations::Show.new(context, annotation: expanded_annotation)
      end
    end
    nested :annotation
  end
end
