# -*- encoding : utf-8 -*-

class Admin::UsersController < AdminController

  layout "admin"

  def exit
    cookies[:auth_token] = false
    redirect_to :back
  end

  def login
    if @user
      redirect_to admin_posts_path
    else
      @user = User.new
      render layout: false
    end

  end

  def auth
    @user = User.where(name: params[:user][:name]).first

    if @user.verify_password_key(params[:user][:password_key])

      @user.generate_auth_token

      cookies[:auth_token] = @user[:auth_token] if @user.save

      redirect_to admin_posts_path
    else
      redirect_to :back
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate :page => params[:page], :order => 'id DESC'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.action = 'create'

    respond_to do |format|
      if @user.save
        format.html { redirect_to [ :admin, @user ], notice: 'Пользователь успешно создан.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [ :admin, @user ], notice: 'Пользователь успешно обновлен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
end
