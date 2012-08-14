class PostsController < ApplicationController

	def new
		@insult = Insult.new
		@insult.getRand
	    u = flash[:u]
	    flash[:u] = u
	    @message = Message.new({:insult => insult})
	end

end
