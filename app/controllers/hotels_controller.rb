class HotelsController < ApplicationController
  authorize_resource
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]

  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.all
    @map = []
    now_service = []

    @hotels.each do |hotel|
      hotel.hotel_services.each do |service|
        now_service << service if  service.day_of_the_week.split(',').include?(Date.today.wday.to_s)
      end
      name = "#{now_service[0].name}: #{now_service[0].money}円\n #{now_service[1].name}: #{now_service[1].money}円\n"
      @map << {
        name: name,
        lat: hotel.lat.to_f,
        lng: hotel.lng.to_f
      }
    end
    @map = @map.to_json
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
    @favorite = @hotel.users.where(id: current_user.id).exists?
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    if can? :create, @hotel
      @hotel = Hotel.new(hotel_params)

      respond_to do |format|
        if @hotel.save
          format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
          format.json { render :show, status: :created, location: @hotel }
        else
          format.html { render :new }
          format.json { render json: @hotel.errors, status: :unprocessable_entity }
        end
      end
      return 403
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    if can? :update, @hotel
      respond_to do |format|
        if @hotel.update(hotel_params)
          format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
          format.json { render :show, status: :ok, location: @hotel }
        else
          format.html { render :edit }
          format.json { render json: @hotel.errors, status: :unprocessable_entity }
        end
      end
    else
      return 403
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @hotels = Hotel.search(params["word"])#.page(params[:page]).per(25)
    render :action => "index"
  end

  def favorite_hotel
    UserHotel.create(user: current_user, hotel_id: params["hotel_id"].to_i)
  end

  def delete_favorite_hotel
    UserHotel.find_by(user: current_user, hotel_id: params["hotel_id"].to_i).destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hotel_params
    params.require(:hotel).permit( :user_id_to_manage, :name, :summary, :hotel_url, :street_address, :phone_number, :lat, :lng)
  end
end
