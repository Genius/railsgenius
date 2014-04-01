module UsersHelper
  def avatar(user, size: 25)
    image_tag(user.avatar_url(size: size),
              class: 'user-avatar',
              width:  size,
              height: size)
  end
end
