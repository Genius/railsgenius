class UsersController < ApplicationController
  def show
    user = User.find(params[:id])

    render text: Users::Show.new(user).render,
           layout: :default
  end
end
