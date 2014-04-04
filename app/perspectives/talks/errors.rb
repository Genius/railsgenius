class Talks::Errors < Perspectives::Base
  param :talk

  property(:error_messages) { talk.errors.full_messages }

  property(:error_count) { pluralize(talk.errors.count, 'error') }
  property(:any_errors) { talk.errors.any? }
end
