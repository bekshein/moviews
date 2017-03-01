class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_movie
  before_action :authenticate_user!

  # show new review form
  def new
    @review = Review.new
  end

  # edit review
  def edit
  end

  # post new review
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.movie_id = @movie.id

    if @review.save
      redirect_to @movie, notice: "Review was successfully created."
    else
      render 'new'
    end
  end

  # update review
  def update
    if @review.update(review_params)
      redirect_to @movie, notice: "Review was successfully updated."
    else
      render 'edit'
    end
  end

  # delete review
  def destroy
    @review.destroy
    redirect_to @movie, notice: "Review was successfully destroyed."
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
