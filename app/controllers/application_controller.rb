class ApplicationController < ActionController::Base
    #protect_from_forgery unless: -> { request.format.json? }
    protect_from_forgery with: :null_session

    # override devise method to redirect to items list
    def after_sign_in_path_for(resource)
      items_url
    end
end
 