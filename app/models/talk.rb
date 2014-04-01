class Talk < ActiveRecord::Base
  validates :title, :abstract, :speaker, presence: true
  belongs_to :speaker, class_name: 'User'
end
