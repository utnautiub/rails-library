class Api::V1::GenresController < ApplicationController
  def index
    @genres = Genre.all
    if @genres.any?
      @status_code = 1
      @custom_message = "Lấy dữ liệu thành công"
    else
      @status_code = 0
      @custom_message = "Không có dữ liệu"
    end
  end

  def show
    @genre = Genre.find_by(id: params[:id], delete_flag: false)
    if @genre
      @status_code = 1
      @custom_message = "Tìm thành công"
    else
      @status_code = 0
      @custom_message = "Tìm thất bại"
    end
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      @status_code = 1
      @custom_message = "Thêm thành công"
      @genres = [ @genre ]
    else
      @status_code = 0
      @custom_message = "Thêm thất bại"
      @genres = []
    end
  end

  def update
    @genre = Genre.find_by(id: params[:id])

    if @genre.nil? || @genre.delete_flag
      @status_code = 0
      @custom_message = "Không tìm thấy thể loại tương ứng hoặc đã bị xóa"
      return
    end

    if @genre.update(genre_params)
      @status_code = 1
      @custom_message = "Cập nhật thể loại thành công"
    else
      @status_code = 0
      @custom_message = "Cập nhật thể loại thất bại"
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre && @genre.delete_flag === false
      @status_code = 1
      @custom_message = "Xóa mềm thành công"
      @genre.update(delete_flag: true)
    else
      @status_code = 0
      @custom_message = "Xóa thất bại"
    end
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
