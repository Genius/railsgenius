require 'spec_helper'

describe "annotations/index" do
  before(:each) do
    assign(:annotations, [
      stub_model(Annotation),
      stub_model(Annotation)
    ])
  end

  it "renders a list of annotations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
