class MessagesController < ApplicationController
  
  def new
    noun = InsultNoun.first(:offset => rand(InsultNoun.count)).noun
    adjective = InsultAdjective.first(:offset => rand(InsultAdjective.count)).adjective
    insult = "#{adjective} #{noun}"
    t = flash[:t]
    n = flash[:n]
    @message = Message.new({:t => t, :n => n, :insult => insult})
  end
  
  def create
    @message = Message.create(params[:message])
    if @message.valid?
      account = Account.find_by_oauth_token(@message.t)
      if @message.n === "facebook"
        account.fb_post("#{@message.to} is a #{@message.insult} #tweetaninsult")
      else
        account.twitter_post("#{@message.to} is a #{@message.insult} #tweetaninsult")
      end
      flash[:notice] = "Sweet! You successfully (and publicly) bashed that no good #{@message.to} proper!"
      redirect_to :action => 'show', :id => @message.id
    else
      render :action => 'new', :notice => 'Need to fill out all the fields, ya douche!'
    end
  end
  
  def show
    @message = Message.find(params[:id])
    @sent = "@#{@message.to} is a #{@message.insult} #tweetaninsult"
  end
  
end
