class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_convenience_stores, only: [:new, :create, :edit, :update]

  def index
    @reviews = Review.includes(:user, :categories, :tastes, :regions).order(created_at: :desc)
  end

  def show
  end

  def new
    @review = current_user.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    
    if @review.save
      redirect_to @review, notice: 'レビューが正常に投稿されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'レビューが正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'レビューが正常に削除されました。'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_convenience_stores
    @convenience_stores = ConvenienceStore.all
  end

  def review_params
    params.require(:review).permit(
      :convenience_store_name,
      :product_name,
      :rating,
      :body,
      :image,
      category_ids: [],
      taste_ids: [],
      region_ids: []
    )
  end
end
