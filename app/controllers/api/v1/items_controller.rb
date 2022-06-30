class Api::V1::ItemsController < ApplicationController
  prepend_before_action :authenticate
  before_action :set_item, only: %i[ show edit update destroy ]
    
  # disable CSRF-TOKENS
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    if request.GET != {}            
      @items = Item.where(brand: request.GET[:brand], user_id: @current_user.id)
    else
      @items = Item.where(user_id: @current_user.id)
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
    @item.user_id = @current_user.id

    @item.save

    render json: { message: "Created item with id #{@item.id}." }, status: 200
  end

  # PATCH /items/:id
  def update
    @item.update(params.permit(:name, :brand))

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

    if @item.user_id != @current_user&.id
      render json: { message: "Access denied." }, status: 403
    end
  end

  def render_404
    render json: { error: "No item with given id #{params[:id]} found." }, status: 404
  end

  def authenticate
    authenticate_with_http_token do |token, options|
      profile = Profile.find_by api_key: token
      @current_user = profile&.user

      if @current_user.nil?
        # From the rails docs:
        # If a "before" filter renders or redirects, the action will not run.
        # If there are additional filters scheduled to run after that filter, they are also cancelled.
        render json: { message: "Authentication failed." }, status: 403
      end
    end
  end
end