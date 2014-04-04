module Users::Helpers
  def display_name(user)
    [user.first_name, user.last_name].join(' ')
  end
end
