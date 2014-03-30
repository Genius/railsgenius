module UsersHelper
  def avatar(user)
    image_tag(user.avatar_url,
              class: 'user-avatar',
              width:  25,
              height: 25)
  end
end
