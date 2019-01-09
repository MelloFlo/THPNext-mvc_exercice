# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all
    end

    def update
      @item = Item.find(params[:id])
      puts @item.id
      if params[:item][:discount_percentage].to_f > 100
        flash[:error] = "Veuillez entrer une réduction valable"
      else
        item_params = params.require(:item).permit(:discount_percentage)
        @item.update(item_params)
        flash[:notice] = "L'item a bien été modifié"
      end
      if @item.discount_percentage.positive?
        @item.update(has_discount: true)
      elsif @item.discount_percentage = 0
        @item.update(has_discount: false)
      end
      redirect_to administration_items_path
      # respond_to do |format|
      #  format.html { administration_item_path(params[:id]) }
      #  format.js
      # end
    end
  end
end
