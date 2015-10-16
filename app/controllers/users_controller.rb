class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    respond_to do |format|
      if @user.save
        user = client.users.create(
            first_name: @user.first_name,
            last_name: @user.last_name,
            email: @user.email,
            address_line1: @user.address_line1,
            state: @user.state,
            city: @user.city,
            zip: @user.zip,
            country: @user.country,
            dob: @user.dob
          )
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    user = client.users.find(@user.id)
    respond_to do |format|
      if @user.update(user_params)
        user.update(
          first_name: @user.first_name,
          last_name: @user.last_name,
          email: @user.email,
          address_line1: @user.address_line1,
          state: @user.state,
          city: @user.city,
          zip: @user.zip,
          country: @user.country,
          dob: @user.dob
          )
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address_line1, :country, :city, :state, :zip, :dob)
    end
end
