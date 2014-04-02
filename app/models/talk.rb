class Talk < ActiveRecord::Base
  validates :title, :abstract, :speaker, presence: true
  belongs_to :speaker, class_name: 'User'

  def abstract_as_html
    HTML::Sanitizer.new.sanitize(abstract).html_safe
  end
end
