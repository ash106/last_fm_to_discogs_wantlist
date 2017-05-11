class UsersController < ApplicationController
  def show
    @username = params[:username] || "saorock"
    lastfm = Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
    @top_albums = lastfm.user.get_top_albums(user: @username, period: "6month", limit: 10)

    @discogs_results = {}
    auth_wrapper = Discogs::Wrapper.new("Lastfm to Discogs Wantlist", user_token: ENV["DISCOGS_TOKEN"])
    @top_albums.each do |album|
      search = auth_wrapper.search("#{album["name"]} #{album["artist"]["name"]}", per_page: 20, type: :release)
      @discogs_results[album["name"]] = search.results
    end
  end
end
