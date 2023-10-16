class Admin::ShopsController < ApplicationController
    before_action :if_not_admin
    before_action :set_cake, only:index
    
    private
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end
end
