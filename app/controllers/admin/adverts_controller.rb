# -*- encoding : utf-8 -*-

class Admin::AdvertsController < AdminController

  layout "admin"

  # GET /adverts
  # GET /adverts.json
  def index
    @adverts = Advert.paginate :page => params[:page], :order => 'id DESC'
  end

  # GET /adverts/1
  # GET /adverts/1.json
  def show
    @advert = Advert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advert }
    end
  end

  # GET /adverts/new
  # GET /adverts/new.json
  def new
    @advert = Advert.new
  end

  # GET /adverts/1/edit
  def edit
    @advert = Advert.find(params[:id])
  end

  # POST /adverts
  # POST /adverts.json
  def create
    @advert = Advert.new(params[:advert])

    respond_to do |format|
      if @advert.save
        format.html { redirect_to [:admin,@advert], notice: 'Рекламный блок успешно сохранен.' }
        format.json { render json: @advert, status: :created, location: @advert }
      else
        format.html { render action: "new" }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adverts/1
  # PUT /adverts/1.json
  def update
    @advert = Advert.find(params[:id])

    respond_to do |format|
      if @advert.update_attributes(params[:advert])
        format.html { redirect_to [:admin,@advert], notice: 'Рекламный блок успешно сохранен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy

    respond_to do |format|
      format.html { redirect_to admin_adverts_url }
      format.json { head :no_content }
    end
  end
end
