require 'spec_helper'

describe "annotations/new" do
  before(:each) do
    assign(:annotation, stub_model(Annotation).as_new_record)
  end

  it "renders new annotation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", annotations_path, "post" do
    end
  end
end
