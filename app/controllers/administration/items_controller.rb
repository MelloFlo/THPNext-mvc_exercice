# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    before_action :set_item, only: [:update]
    def index
      @items = Item.all
    end

    def update
      if @item.update(item_params)
        redirect_to administration_items_path, notice: "L'item a bien été modifié"
      else
        redirect_back fallback_location: administration_items_path, alert: "Veuillez entrer une réduction valable"
      end
      # respond_to do |format|
      #  format.html { administration_item_path(params[:id]) }
      #  format.js
      # end
    end

    private

    def item_params
      params.require(:item).permit(:discount_percentage)
    end

    def set_item
      @item = Item.find(params[:id])
    end
  end
end
