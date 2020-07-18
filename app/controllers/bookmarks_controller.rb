class BookmarksController < ApplicationController

  def create
    @item = Item.find(params[:format])
    bookmark = current_user.bookmarks.build(item_id: @item.id)
    # あとでparams[:item_id]
    bookmark.save!
    redirect_to item_path(@item.id), success: t('.flash.bookmark')
    # あとでpath設定にする
  end

  def destroy
    @item = Item.find(params[:id])
    current_user.bookmarks.find_by(item_id: @item.id).destroy!
     # あとでparams[:item_id]
    redirect_to item_path(@item.id), success: t('.flash.not_bookmark')
    # あとでpathの設定にする
  end

end
