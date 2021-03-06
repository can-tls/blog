class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  
  def new
    @tag = Tag.new
  end   

  def create
    @tag = Tag.create(tag_params)
    @tag.save
    @tags = Tag.all
    render 'index'
  end

  def update
    @tag.update(tag_params)
    redirect_to '/tags'
    flash[:success] = t(".updated")
  end

  def destroy
    @tag.destroy
    redirect_to '/tags'
  end

  def index
    @tags = Tag.all
  end

  private
  
    def tag_params
      params.require(:tag).permit(:name, :id, :created_at, :updated_at, :micropost_id)
    end

    def set_tag
      @tag = Tag.find(params["id"])
    end
end
