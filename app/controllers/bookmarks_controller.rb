class BookmarksController < ApplicationController

  def update
    bookmark = Bookmark.where(user_id: current_user.id, topic_id: params[:bookmark][:topic_id]).first_or_initialize(done: true)
    bookmark.update_attributes(done:!bookmark.done)
    @done = bookmark.done
    @topic_id = params[:bookmark][:topic_id]
  end

end
