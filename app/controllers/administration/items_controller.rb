# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      redirect_to administration_items_path
    end
  end
end
