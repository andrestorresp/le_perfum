class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  # before_action :set_product, only: [ :destroy]
  def index
    @reviews = Review.all
  end

  # def new
  #   # @review = Review.new
  #   @product = Product.find(params[:product_id])
  # end

  def show; end

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product_id = @product.id
    @review.user = current_user
    if @review.save!
      redirect_to product_path(@product)
    else
      render "products/show", status: :unprocessable_entity
    end
  end

  def edit;end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to product_path(@review.product), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:comment)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
