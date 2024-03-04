class CheckoutsController < ApplicationController
  before_action :set_product, only: :destroy
  # before_action :set_product, only: %i[new create]
  def index
    @products = Product.all
  end

  def new
    @product = Product.find(params[:product_id])
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)
    if @checkout.save
      redirect_to checkout_path(@checkout)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def checkout_params
    params.require(:checkout).permit(:user_id, :product_id, :transaction_date, :price)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
