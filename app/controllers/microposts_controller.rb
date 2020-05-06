class MicropostsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]
  
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
    end

    def index
      sort = params[:sort]
      @microposts = Micropost.all.order(sort)
    end

    def edit
      @micropost = Micropost.find(micropost["id"])
      @tag = @micropost.tag
    end
  
    def update
      @micropost = Micropost.find(micropost["id"])
      if @micropost.update_attributes(micropost_params)
        flash[:success] = "Post updated"
        redirect_to @micropost
      else
        render 'edit' 
      end
    end

    def destroy
      @micropost = Micropost.find(params["id"])
      @micropost.destroy
      redirect_to '/all'
    end

    private
      def user_params
        params.require(:user).permit(:id, :name, :email, :password, :password_confirmation) #confirmation entfernt
      end

      def tag_params
        params.require(:tag).permit(:name)
      end

      def sorting
        params.require(:sort)
      end
  
      def micropost_params
        params.require(:micropost).permit(:titel, :content, :id, :user_id, :tags)
      end

      def micropost
        params.permit(:id, :content, :titel, :user_id) #brauch ich das?
      end

  end
  