module Users
  class Show < Mustache
    include ActionView::Helpers::AssetTagHelper
    include Rails.application.routes.url_helpers
    AVATAR_SIZE = 100

    attr_reader :current_user, :user
    def initialize(current_user, user)
      @current_user, @user = current_user, user
    end

    delegate :email, :about_me, to: :user

    def display_name
      "#{user.first_name} #{user.last_name}".squish
    end

    def edit
      user == current_user || current_user.try(:admin?)
    end

    def edit_path; edit_user_path(user); end

    def go_back_path; users_path; end

    def avatar
      image_tag(user.avatar_url(size: AVATAR_SIZE),
                class: 'user-avatar',
                width:  AVATAR_SIZE,
                height: AVATAR_SIZE)
    end
  end
end
