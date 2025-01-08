class Api::V1::BooksController < Api::V1::BaseController
  before_action :authorize_user, only: [ :index, :show ]
  before_action :authorize_admin, only: [ :create, :update, :destroy ]
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

    if @book
      @book.update(delete_flag: true)
    else
      render json: @book.errors, status: 422
    end
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :subtitle, :author_id, :genre_id, :publishing_year, :quantity_in_stock, :description, :delete_flag)
  end
end
