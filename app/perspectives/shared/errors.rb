class Shared::Errors < Perspectives::Base
  param :object

  property(:error_messages) do
    object.errors.full_messages.map { |msg| {msg: msg } }
  end
  property(:name) { object.class.name.humanize }

  property(:error_count) { pluralize(object.errors.count, 'error') }
  property(:any_errors) { object.errors.any? }
end
