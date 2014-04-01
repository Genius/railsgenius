class Annotation < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :talk

  validates :referent, :body, :talk, :created_by, presence: true
end
