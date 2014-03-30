module Users
  class Show < Mustache
    attr_reader :user
    def initialize(user)
      @user = user
    end

    def email
      user.email
    end
  end
end
