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
  
    def destroy
    end

    def show
        @microposts = @user.microposts.paginate(page: params[:page])
        #@micropost = Micropost.find_by(index)
    end
  
    private
  
      def micropost_params
        params.require(:micropost).permit(:titel, :content)
      end
  end
  