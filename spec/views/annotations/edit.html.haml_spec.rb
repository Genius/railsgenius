require 'spec_helper'

describe "annotations/edit" do
  before(:each) do
    @annotation = assign(:annotation, stub_model(Annotation))
  end

  it "renders the edit annotation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", annotation_path(@annotation), "post" do
    end
  end
end
