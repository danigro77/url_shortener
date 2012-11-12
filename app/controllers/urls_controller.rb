class UrlsController < ApplicationController
	def index
    @urls = Url.all
  end

  def show
    url = Url.redirect_to_original(params[:short_url])
    url.present? ? redirect_to(url) : redirect_to(root_path, :notice => "This URL doesn't exist")
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new params[:url]
    if @url.save
      redirect_to root_path
    else
      render :new
    end
  end

end
