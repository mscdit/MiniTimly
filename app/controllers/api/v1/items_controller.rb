class Api::V1::ItemsController < ApplicationController
    skip_before_action :verify_authenticity_token

    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    before_action :set_item, only: %i[ show edit update destroy ]

    def index
        if request.GET != {}            
            @items = Item.where(brand: request.GET[:brand])
        else
            @items = Item.all
        end

        render json: @items, status: 200
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
    end

    def render_404
        render json: { error: "No item with given id #{params[:id]} found." }, status: 404
    end
end