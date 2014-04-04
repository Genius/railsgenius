class Talks::Form < Perspectives::Base
  include Users::Helpers

  param :talk

  delegate_property :title, :abstract, :speaker_id, to: :talk

  nested 'errors', talk: :talk

  property :talks_path

  property(:speakers) do
    User.all.map do |u|
      {name: display_name(u), id: u.id, selected: speaker_id == u.id}
    end
  end

  property(:form_class) do
    talk.new_record? ? 'new_talk' : 'edit_talk'
  end

  property(:form_id) do
    talk.new_record? ? 'new_talk' : "edit_talk_#{talk.id}"
  end

  property(:submit_to) do
    talk.new_record? ? talks_path : talk_path(talk)
  end

  property(:submit_method) { !talk.new_record? && 'patch' }
end
