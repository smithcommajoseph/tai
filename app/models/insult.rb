class Insult < ActiveRecord::Base

	def getRand
		self.first(:offset => rand(Message.count)).text
	end

end
