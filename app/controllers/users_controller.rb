class UsersController < ApplicationController

	def new
		auth = request.env["omniauth.auth"]
		network = params[:network]

		@user = User.find_or_create_by_network_and_uid(network, auth['uid'])
		@user.save

		redirect_to users_interstitial_url(:u => @user.id)
	end

	def interstitial
	    render :layout => 'interstitial'
	    flash[:notice] = 'Account activated!' 
	    flash[:u] = params[:u]
  	end


end
