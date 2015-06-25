# -*- encoding : utf-8 -*-

class Admin::LinksController < AdminController

  layout "admin"

  # GET /links
  # GET /links.json
  def index
    @links = Link.paginate :page => params[:page], :order => 'id DESC'
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    @post = @link.post

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new
    @post = Post.find(params[:post_id])
    @link[:post_id] = @post[:id]
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
    @post = @link.post
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])


    respond_to do |format|
      if @link.save
        format.html { redirect_to [:admin,@link], notice: 'Ссылка успешно создана.' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to [ :admin, @link ], notice: 'Ссылка успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to admin_links_url }
      format.json { head :no_content }
    end
  end
end
