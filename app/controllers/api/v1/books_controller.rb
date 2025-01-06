class Api::V1::BooksController < ApplicationController
  def index
    @books = Book.where(delete_flag: false)
    render json: @books
  end

  def show
    @book = Book.find(params[:id])
    render json: @book
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: 422
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: 422
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.update(delete_flag: true) # Soft-delete
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :subtitle, :author_id, :genre_id, :publishing_year, :quantity_in_stock, :description, :delete_flag)
  end
end
