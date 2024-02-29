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
    if @product.save
      redirect_to product_path(@product), notice: 'Producto creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Define la lógica para editar un producto si es necesario
  end

  def update
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
    params.require(:product).permit(:name, :description, :price, :user_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
