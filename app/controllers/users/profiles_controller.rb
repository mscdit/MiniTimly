class Users::ProfilesController < ApplicationController
  def index
    @profile = current_user.profile
  end

  def create
  end

  def generateApiKey
    current_user.profile.api_key = Random.new_seed.to_s

    @profile = current_user.profile
    @profile.save

    redirect_to action: 'index'
    #render "index"
  end
end
