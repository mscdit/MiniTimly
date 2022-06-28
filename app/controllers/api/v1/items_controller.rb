class Api::V1::ItemsController < ApplicationController
    #skip_before_action :verify_authenticity_token

    #include ApiKeyAuthenticatable
    prepend_before_action :authenticate

    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    before_action :set_item, only: %i[ show edit update destroy ]

    def index
        if @current_profile != nil
            if request.GET != {}            
                @items = Item.where(brand: request.GET[:brand])
            else
                @items = Item.where(user_id: @current_profile.user_id)
            end

            render json: @items, status: 200
        else
            render json: { message: "Access denied" }, status: 403
        end
    end

    def show
        render json: @item, status: 200
    end

    def create
        @item = Item.new

        @item.name = params[:name]
        @item.brand = params[:brand]

        @item.save
    end

    # PUT /items/:id
    def update
        @item.attributes.each do |key, value|
            if (params[key] != nil) && (key != "id")
                @item.update(key => params[key])
            end
        end

        render json: { message: "Updated item with id #{params[:id]}." }, status: 200
    end

    def destroy
        @item.destroy

        render json: { message: "Item with id #{params[:id]} deleted." }, status: 200
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
        @item = Item.find(params[:id])

        if @item.user_id != @current_profile&.user_id
            respond_to do |format|
              format.html { redirect_to root_url, alert: "Access denied." }
              format.json { render json: { message: "Access denied." }, status: 403 }
            end
        end
    end

    def render_404
        render json: { error: "No item with given id #{params[:id]} found." }, status: 404
    end

    def authenticate
        authenticate_with_http_token do |token, options|
            @current_profile = Profile.find_by api_key: token
        end
    end
end