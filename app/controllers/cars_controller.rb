class CarsController < ApplicationController
  before_action :authenticate_user!, :except => [ :show, :index ]
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    if params.has_key?(:space_id)
      provided_space_id = params[:space_id] # get the space_id
      car_ids_belonging_to_the_space_id = CarsSpaces.select('car_id').where(space_id: provided_space_id) # array with car_id from the join table that belong to the space_id
      @cars = Car.where(id: car_ids_belonging_to_the_space_id)
    else
      @cars = Car.all
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
    @spaces = Space.all
  end

  # GET /cars/1/edit
  def edit
    @spaces = Space.all
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id # current_user is the variable that devise created

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:name, :space_ids => [])
    end
end
