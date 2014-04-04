module Users
  class Show < Perspectives::Base
    include Users::Helpers

    cache { user }

    param :user
    delegate_property :email, :about_me, to: :user

    property(:name) do
      display_name(user)
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
