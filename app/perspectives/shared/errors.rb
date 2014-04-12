class Shared::Errors < Perspectives::Base
  param :object

  property(:error_messages) { object.errors.full_messages }
  property(:name) { object.class.name.humanize }

  property(:error_count) { pluralize(object.errors.count, 'error') }
  property(:any_errors) { object.errors.any? }
end
