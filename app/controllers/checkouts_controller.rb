class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  def index
    @products = Product.all
  end

  def new
    @product = Product.find(params[:product_id])
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.user_id = current_user.id
    @checkout.transaction_date = Date.today
    @product = Product.find(params[:product_id])
    @checkout.product_id = @product.id
    @checkout.price = @product.price

    if @checkout.save
      redirect_to checkout_path(@checkout)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def user_checkouts
    @user_checkouts = current_user.checkout
  end

  private

  def checkout_params
    params.require(:checkout).permit(:reference_info, :photo)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
