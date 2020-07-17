class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(item_id: 2)
    # あとでparams[:item_id]
    bookmark.save!
    redirect_to "http://localhost:3000/items/show", success: t('.flash.bookmark')
    # あとでpath設定にする
  end

  def destroy
    current_user.bookmarks.find_by(item_id: 2).destroy!
     # あとでparams[:item_id]
    redirect_to "http://localhost:3000/items/show", success: t('.flash.not_bookmark')
    # あとでpathの設定にする
  end
end
