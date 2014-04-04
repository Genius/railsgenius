class Talks::Edit < Perspectives::Base
  param :talk
  property :talks_path
  property(:path) { talk_path(talk) }

  nested 'form', talk: :talk
end
