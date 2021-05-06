class MicropostsController < ApplicationController
  before_action :current_user, only: [:create, :destroy]
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_img, only: [:new, :edit, :create, :update]
  before_action :set_tag, only: [:index, :edit, :update]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t(".create")
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  def show
    @tags = @micropost.tags
    if current_user.present?
      @comment = Comment.new(name: current_user.name, user_id: current_user.id)
    else
      @comment = Comment.new
    end
  end

  def index
    sort = params[:sort]
    @microposts = Micropost.paginate(page: params[:page]).order(sort)
  end

  def edit
    if @micropost.user != current_user
      redirect_to @micropost
      flash[:danger] = t(".not")
    end
  end

  def update
    if current_user == @micropost.user
      @micropost.update(micropost_params.merge({tags: Tag.find(update_tags)}))
      flash[:success] = t(".updated")
    else
      flash[:danger] = t(".not")
    end
    redirect_to @micropost
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

    def set_tag
      @tags = Tag.all
    end

    def sorting
      params.require(:sort)
    end

    def update_tags
      params[:tag].present? ? params.require(:tag) : []
    end

    def micropost_params
      params.require(:micropost).permit(:titel, :content, :id, :user_id, :tag_id, :img_url)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :defaultpw, :avatar, :avatar_url, :id)
    end
end