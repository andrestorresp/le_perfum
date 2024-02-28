class ProductsController < ApplicationController
  before_action :set_product, only: :destroy
  # before_action :set_product, only: %i[new create]
  def index
    @products = Product.all
  end

  def new
    @products = Product.new
  end

  def show; end

  def create
    @product = Product.new(product_params)
    # @product.list = @list
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

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
    redirect_to product_path(@product.list)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :user_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  # def set_product
  #   @product = Product.find(params[:product_id])
  # end
end
