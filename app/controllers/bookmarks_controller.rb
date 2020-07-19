class BookmarksController < ApplicationController

  def create
    @item = Item.find(params[:format])
    bookmark = current_user.bookmarks.build(item_id: @item.id)
    bookmark.save!
    redirect_to item_path(@item.id), success: t('.flash.bookmark')
  end

  def destroy
    @item = Item.find(params[:id])
    current_user.bookmarks.find_by(item_id: @item.id).destroy!
    redirect_to item_path(@item.id), success: t('.flash.not_bookmark')
  end

end
