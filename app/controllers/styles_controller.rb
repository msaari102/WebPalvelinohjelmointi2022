class StylesController < ApplicationController
  before_action :set_style, only: %i[show edit update destroy]

  def index
    @styles = Style.all
  end

  def new
    @style = Style.new
  end

  # GET /breweries/1 or /breweries/1.json
  def show
  end

  def create
    @style = Style.new(styles_params)

    if @style.save
      redirect_to styles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    style = Style.find params[:id]
    style.delete
    redirect_to styles_path(current_user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_style
    @style = Style.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def styles_params
    params.require(:style).permit(:name, :description)
  end
end
