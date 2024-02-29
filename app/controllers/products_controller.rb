class ProductsController < ApplicationController
  before_action :set_product, only: :destroy
  # before_action :set_product, only: %i[new create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    # Define la lógica para mostrar un producto si es necesario
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    # @product.list = @list
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'Producto actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, notice: 'Producto eliminado exitosamente.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
