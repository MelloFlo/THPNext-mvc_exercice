# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all
    end

    def update
      @item = Item.find(params[:id])
      puts @item.id
      item_params = params.require(:item).permit(:discount_percentage)
      @item.update(item_params)

      if @item.discount_percentage.positive?
        @item.update(has_discount: true)
      elsif @item.discount_percentage = 0
        @item.update(has_discount: false)
      end
      flash[:notice] = "L'item a bien été modifié"
      redirect_to administration_items_path
      # respond_to do |format|
      #  format.html { administration_item_path(params[:id]) }
      #  format.js
      # end
    end
  end
end
