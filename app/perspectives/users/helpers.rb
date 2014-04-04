module Users::Helpers
  def display_name(user)
    [user.first_name, user.last_name].join(' ')
  end

  def avatar(user, size: 100)
    image_tag(user.avatar_url(size: size),
              class: 'user-avatar',
              width:  size,
              height: size)
  end
end
