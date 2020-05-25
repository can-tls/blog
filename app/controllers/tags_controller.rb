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

    def show
        @tag = Tag.find(params[:id])
    end

    def index
        @tags = Tag.all
    end

    def delete
    end

    private

    def tag_params
        params.require(:tag).permit(:name, :id, :created_at, :updated_at, :micropost_id)
    end

    def tags
        params.permit(:id, :name, :micropost_id)
    end
end