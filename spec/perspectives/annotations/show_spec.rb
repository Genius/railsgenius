# spec/perspectives/annotations/show_spec.rb
require 'spec_helper'

describe Annotations::Show do
  it 'should be easy to test!' do
    user = double(:user)
    annotation = double(:annotation, created_by: user)

    annotations_show = described_class.new({current_user: user}, annotation: annotation)

    annotations_show.edit.should be_true
  end
end
