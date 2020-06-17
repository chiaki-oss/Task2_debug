class HomeController < ApplicationController
  def top
  end

  def about
  end

  def logout
		session[:user_id] = nil
		redirect_to root_path, notice: "Signed out successfully."
	end
end
