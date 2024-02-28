class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: :destroy
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def show; end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new, status: :unprocessable_entity
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
    redirect_to review_path, status: :see_other
  end

  private

  def review_params
    params.require(:product).permit(:comment, :user_id, :product_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
