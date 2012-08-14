class MessagesController < ApplicationController

	def new
		insult = Message.first(:offset => rand(Message.count)).text
	    u = flash[:u]
	    flash[:u] = u
	    @message = Message.new({:insult => insult})
	end

end
