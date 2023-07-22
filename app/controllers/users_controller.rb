class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @profile = user.profile
    @occupation = user.occupation
    @prototypes = user.prototypes
    @position = user.position
  end
end
