# -*- encoding : utf-8 -*-
class Admin::PostsController < AdminController
  layout "admin"

  # GET /posts
  # GET /posts.json
  def index

    @post = Post.new(params[:post])

    where_1 = (@user.no_admin?) ? { user_id: @user.id } : []
    where_2 = (params[:post]) ? [ "name LIKE :name", { name: "%#{params[:post][:name]}%" } ] : []


    @posts = Post.where(where_1).where(where_2).order('created_at DESC').paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @categories = Category.all
    @categories = get_categories
    @post = Post.new
    @post.created_at = l(Time.now, format: :datetime)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all
    @categories = get_categories
    @post = Post.find(params[:id])

    edit_or_redirect

  end

  # POST /posts
  # POST /posts.json
  def create
    @categories = Category.all
    @categories = get_categories
    @post = Post.new(params[:post])

    set_user_id

    respond_to do |format|
      if @post.save
        format.html { redirect_to [:admin, @post], notice: 'Статья успешно сохранена.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @categories = Category.all
    @categories = get_categories
    @post = Post.find(params[:id])

    edit_or_redirect

    set_user_id

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [:admin, @post], notice: 'Статья успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    edit_or_redirect

    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  def set_user_id
    if @user.no_admin?
      @post.user_id = @user.id
    end
  end

  def edit_or_redirect
    unless can 'edit_post'
      redirect_to admin_posts_path
    end
  end

end
