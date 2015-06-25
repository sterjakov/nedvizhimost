# -*- encoding : utf-8 -*-
class Admin::HousesController < AdminController
  layout "admin"

  # GET
  # Одобрить
  def approve
    @house = House.where(id: params[:id]).first
    @house.status = 1
    @house.fields_type = @house.realty_type_number(params[:realty_type])
    @house.save
    redirect_to request.referer
  end

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.where(:realty_type => params[:realty_type] == 'sell' ? 1 : 2).paginate( page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @houses }
    end
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @house = House.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @house }
    end
  end

  # GET /houses/new
  # GET /houses/new.json
  def new
    @house = House.new
    @realty_type = @house.realty_type_number(params[:realty_type])
    
    3.times do
      photo = @house.photos.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @house }
    end
  end

  # GET /houses/1/edit
  def edit
    @house = House.find(params[:id])
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(params[:house])

    respond_to do |format|
      if @house.save
        realty_type = @house.realty_type == 1 ? 'sell' : 'rent'
        format.html { redirect_to admin_house_path(@house, :realty_type => realty_type), notice: 'Недвижимость успешно сохранена.' }
        format.json { render json: @house, status: :created, location: @house }
      else
        format.html { render action: "new" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /houses/1
  # PUT /houses/1.json
  def update
    @house = House.find(params[:id])
    @realty_type = @house.realty_type_number(params[:realty_type])

    respond_to do |format|
     if @house.update_attributes(params[:house])

        format.html { redirect_to admin_house_path(:realty_type => params[:realty_type]), notice: 'Недвижимость успешно обновлена.' }
        format.json { head :no_content }

      else
        format.html { render action: "edit" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house = House.find(params[:id])
    @house.destroy

    respond_to do |format|
      format.html { redirect_to admin_houses_url(:realty_type => params[:realty_type]) }
      format.json { head :no_content }
    end
  end
end
