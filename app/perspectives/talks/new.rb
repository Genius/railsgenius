class Talks::New < Perspectives::Base
  param :talk

  property :talks_path

  nested 'form', talk: :talk, method: 'post'
end
