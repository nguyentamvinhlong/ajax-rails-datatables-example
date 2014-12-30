class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    totalrecords = User.count
    start = params[:start].present? ? params[:start] : 0
    length = params[:length].present? ? params[:length] : 1
    keyword = ''
    if params[:search].present?
      if params[:search][:value].present?
        keyword = params[:search][:value]
      end
    end
    data = {}
    data[:sEcho] = 0
    data[:iTotalRecords] = totalrecords
    data[:iTotalDisplayRecords] = totalrecords
    data[:aaData] = []
    list_user = User.where("name LIKE '%#{keyword}%' OR phone LIKE '%#{keyword}%' OR address LIKE '%#{keyword}%'").offset(start).limit(length)
    list_user = User.all if keyword.nil?
    list_user.each do |user|
      data[:aaData] << ["#{user[:name]}", "#{user[:phone]}", "#{user[:address]}"]
    end

    respond_to do |format|
      format.html
      # format.json { render json: UserDatatable.new(view_context) }
      format.json { render json: data.to_json }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
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

    respond_to do |format|
      if @user.save
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
    respond_to do |format|
      if @user.update(user_params)
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
      params.require(:user).permit(:name, :phone, :address)
    end
end
