class PicturesController < ApplicationController
  before_action :set_picture, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user, only: [ :edit, :update, :destroy ]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
  end

  def create
  @picture = current_user.pictures.build(picture_params)
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: "Picture was successfully created." 
    else
      render :new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "Picture was successfully updated." 
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
      redirect_to pictures_url, notice: "Picture was successfully destroyed." 
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

  def authenticate_user
    unless @picture.user == current_user
      redirect_to pictures_path
    end
  end

end
