# frozen_string_literal: true

module Administration
  class ProfilesController < ApplicationController
    before_action :set_profile

    def show; end

    def send_email
      @profile.send_email
      redirect_back fallback_location: root_path
    end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end
  end
end
