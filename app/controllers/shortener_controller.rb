class ShortenerController < ApplicationController
  def index
  end

  def create
    result = UrlCreator.new(params[:url]).call
    render json: result[:data], status: result[:http_code]
  end

  def show
    link = ShortUrl.where(short_url: params[:id]).first
    if link
      ShortUrl.update_counters(link, clicks: 1)
      redirect_to link.url, status: :moved_permanently
    else
      redirect_to root_path
    end
  end
end
