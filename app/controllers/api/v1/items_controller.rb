class Api::V1::ItemsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @items = Item.all
        render json: @items
    end

    def show
        @item = Item.find(params[:id])
        render json: @item
    end

    def create
        @item = Item.new

        @item.name = params[:name]
        @item.brand = params[:brand]

        @item.save
    end

    # PUT /items/:id
    def update
        @item = Item.find(params[:id])
        if @item
            @item.update(:name => params[:name], :brand => params[:brand])
        else
            render json: { error: 'No item with given id #{params[:id]} found.' }, status: 400
        end
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy

        respond_to do |format|
            format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
            format.json { head :no_content }
        end
    end
end