class TagsController < ApplicationController
    def new
        @tag = Tag.new
    end   

    def create
        @tag = Tag.create(tag_params)
        if @tag.save
            @tags = Tag.all
            render 'index'
        end
    end

    def edit
        @tag = Tag.find(tag["id"])
        @tags = Tag.all
    end

    def update
        @tag = Tag.find(tag["id"])
        @tag.update(tag_params)
        redirect_to '/tags'
        flash[:success] = "Tag updated"
    end

    def show
        @tag = Tag.find(params[:id])
    end

    def index
        @tags = Tag.all
    end

    def delete
    end

    private
    def tag
        params.permit(:id, :name)
    end

    def tag_params
        params.require(:tag).permit(:name, :id, :created_at, :updated_at, :micropost_id)
    end
end