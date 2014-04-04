module Users
  class Show < Perspectives::Base
    include ActionView::Helpers::AssetTagHelper

    cache { user }

    param :user
    delegate_property :email, :about_me, to: :user

    property(:display_name) do
      "#{user.first_name} #{user.last_name}".squish
    end

    property(:edit) do
      user == current_user || current_user.try(:admin?)
    end

    property(:edit_path) { edit_user_path(user) }

    property(:go_back_path) { users_path }

    property(:user_avatar) do
      avatar(user)
    end
  end
end
