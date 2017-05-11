class UsersController < ApplicationController
  def show
    @username = params[:username] || "saorock"
    lastfm = Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
    @top_albums = lastfm.user.get_top_albums(user: @username, period: "6month", limit: 10)
  end
end
