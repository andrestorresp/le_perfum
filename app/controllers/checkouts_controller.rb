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
    @checkout.user_id = current_user.id
    @checkout.transaction_date = Date.today
    @product = Product.find(params[:product_id])
    @checkout.product_id = @product.id
    @checkout.price = @product.price
    if @checkout.save!
      redirect_to checkout_path(@checkout)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit;end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to product_path, status: :see_other
  end

  private

  def checkout_params
    params.require(:checkout).permit(:reference_info, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
