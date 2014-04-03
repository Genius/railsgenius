class Talk < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :speaker, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  has_many :annotations
  has_many :contributors, through: :annotations, source: :created_by, class_name: 'User'

  validates :title, :abstract, :speaker, presence: true

  after_save :set_referents, if: :abstract_changed?

  def abstract_as_html
    Nokogiri::HTML(HTML::Sanitizer.new.sanitize(abstract)).tap do |doc|
      doc.css('a[data-id]').each do |a|
        if a['data-id'].blank? || a['data-id'].to_i < 1
          a.swap(a.inner_text)
        else
          a['href'] = tooltip_annotation_path(id: a['data-id'])
        end
      end
    end.to_html.html_safe
  end

  def set_referents
    html = abstract_as_html

    annotations.each do |a|
      a.set_referent(html)
      a.save! if a.referent_changed?
    end
  end
end
