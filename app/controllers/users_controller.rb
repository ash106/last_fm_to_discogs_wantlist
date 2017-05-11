class UsersController < ApplicationController
  def show
    @username = params[:username] || "saorock"
    @top_albums = Rails.cache.fetch("#{@username}_top_albums", expires_in: 20.minutes) do
      lastfm = Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
      lastfm.user.get_top_albums(user: @username, period: "6month", limit: 10)
    end

    @discogs_results = {}
    auth_wrapper = Discogs::Wrapper.new("Lastfm to Discogs Wantlist", user_token: ENV["DISCOGS_TOKEN"])
    @top_albums.each do |album|
      @discogs_results[album["name"]] = Rails.cache.fetch("#{album["name"]}_#{album["artist"]["name"]}", expires_in: 20.minutes) do
        search = auth_wrapper.search("#{album["name"]} #{album["artist"]["name"]}", per_page: 20, type: :release)
        search.results
      end 
    end
    # byebug
  end
end
