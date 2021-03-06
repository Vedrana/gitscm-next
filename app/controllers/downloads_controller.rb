class DownloadsController < ApplicationController

  def index
  end

  def latest
    latest = Rails.cache.read("latest-version")
    render :text => latest
  end

  def guis
    render "downloads/guis/index"
  end

  def logos
    render "downloads/logos/index"
  end

  def gui
    @platform = params[:platform]
    @platform = 'windows' if @platform == 'win'
    render "downloads/guis/index"
  end

  def download
    @platform = params[:platform]
    @platform = 'windows' if @platform == 'win'
    if @platform == 'windows' || @platform == 'mac'
      if @platform == 'windows'
        @project_url = "http://msysgit.github.com/"
      else
        @project_url = "https://github.com/timcharper/git_osx_installer"
      end

      @download = Download.latest_for(@platform)
      @latest = Version.latest_version

      render "downloads/downloading"
    elsif @platform == 'linux'
      render "downloads/download_linux"
    else
      redirect_to '/downloads'
    end
  rescue
    redirect_to '/downloads'
  end
end
