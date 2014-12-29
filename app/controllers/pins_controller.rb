class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin was successfully created.'
      redirect_to @pin
    else
      flash[:danger] = 'There was an error creating the pin.'
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      flash[:success] = 'Pin was successfully updated.'
      redirect_to @pin
    else
      flash[:danger] = 'There was an error updating the pin.'
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      if @pin.nil?
        flash[:danger] = "Not authorized to edit this pin"
        redirect_to pins_path
      end
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
