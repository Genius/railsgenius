class Talk < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :speaker, class_name: 'User'
  belongs_to :created_by, class_name: 'User'
  has_many :annotations
  has_many :contributors, through: :annotations, source: :created_by, class_name: 'User'

  validates :title, :abstract, :speaker, presence: true

  after_save :set_referents, if: :abstract_changed?

  def abstract_as_html
    annos = annotations.index_by(&:id)

    Nokogiri::HTML(abstract_sanitizer.sanitize(abstract)).tap do |doc|
      doc.css('a').each do |a|
        if annos.exclude?(a['data-id'].to_i)
          a.swap(a.inner_text)
        else
          a['href'] = talk_annotation_path(talk_id: id, id: a['data-id'])
          a['data-perspectives-container'] = '#annotation-tooltip'
        end
      end
    end.to_html.html_safe
  end

  def self.abstract_sanitizer
    @abstract_sanitizer ||= HTML::WhiteListSanitizer.new.tap do |sanitizer|
      sanitizer.allowed_attributes << 'data-id'
    end
  end
  delegate :abstract_sanitizer, to: 'self.class'

  def set_referents
    html = abstract_as_html

    annotations.each do |a|
      a.set_referent(html)
      a.save! if a.referent_changed?
    end
  end
end
