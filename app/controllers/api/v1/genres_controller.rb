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
    @genre = Genre.find(params[:id])
    if @genre
      @status_code = 1
      @custom_message = "Tìm thành công"
    else
      @status_code = 0
      @custom_message = "Tìm thất bại"
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
end
