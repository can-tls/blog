class MicropostsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]
    before_action :set_micropost, only: [:show, :edit, :update, :destroy]
    before_action :set_s3_direct_img, only: [:new, :edit, :create, :update]
  
    def create    
      @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url #redircet to post 20.2.
      else
        render 'static_pages/home'
      end
    end

    def new
      @micropost = current_user.microposts.build if logged_in?
    end

    def show
      @micropost = Micropost.find(micropost["id"])
      @tags = @micropost.tags
    end

    def index
      sort = params[:sort]
      @microposts = Micropost.all.order(sort)
      @tags = Tag.all
    end

    def edit
      @micropost = Micropost.find(micropost["id"])
      @microposts = Micropost.all
      @tags = Tag.all
    end
  
    def update
      @microposts = Micropost.all
      @micropost = Micropost.find(micropost["id"])
      @tags = Tag.all
      @micropost.update(micropost_params.merge({tags: Tag.find(update_tags)}))
      redirect_to @micropost
      flash[:success] = "Post updated"
    end

    def destroy
      @micropost = Micropost.find(params["id"])
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

      def update_tags
        if params[:tag].present?
          params.require(:tag)
        else
          []
        end
      end
  
      def micropost_params
        params.require(:micropost).permit(:titel, :content, :id, :user_id, :tag_id, :img_url)
      end

      def micropost
        params.permit(:id, :content, :titel, :user_id, :img_url) #brauch ich das?
      end

  end
  