# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all
    end

    def update
      redirect_to administration_items_path
    end
  end
end
