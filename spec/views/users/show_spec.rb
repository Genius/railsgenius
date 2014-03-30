require 'spec_helper'

describe Users::Show do
  it 'should be easy to test!' do
    user = double(:user, email: 'foo@bar.com')
    users_show = Users::Show.new(user)

    users_show.email.should == user.email
  end
end
