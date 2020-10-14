class MicropostsController < ApplicationController
  before_action :current_user, only: [:create, :destroy]
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_img, only: [:new, :edit, :create, :update]
  
  def create
    if params['updated_img'].present?
      flash[:success] = "Bild aktualisiert"
    else
      @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    end
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def show
    @tags = @micropost.tags
  end

  def index
    sort = params[:sort]
    @microposts = Micropost.all.order(sort)
  end

  def edit
    @tags = Tag.all
  end

  def update
    @tags = Tag.all
    @micropost.update(micropost_params.merge({tags: Tag.find(update_tags)}))
    redirect_to @micropost
    flash[:success] = "Post updated"
  end

  def destroy
    @micropost.destroy
    redirect_to '/all'
  end

  private

    def set_s3_direct_img
      @s3_direct_img = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    def sorting
      params.require(:sort)
    end

    def  update_tags
      unless params[:tag].present?
        params.require(:tag)
      end
    end

    def micropost_params
      params.require(:micropost).permit(:titel, :content, :id, :user_id, :tag_id, :img_url)
    end
end