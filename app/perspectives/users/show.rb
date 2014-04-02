module Users
  class Show < LinearPerspective::Base
    include ActionView::Helpers::AssetTagHelper

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

    property(:avatar) do
      size = 100

      image_tag(user.avatar_url(size: size),
                class: 'user-avatar',
                width:  size,
                height: size)
    end
  end
end
