require 'gossip'
require 'pry'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do 
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  	get '/gossips/:id/' do
  		
  		erb :show, locals: {gossip: Gossip.find(params['id']), hash_comment: Gossip.all_comments}
	end

	get '/gossips/:id/edit' do 
    	erb :edit, {gossip: Gossip.find(params['id'])}
 	 end

 	post '/gossips/:id/edit/' do
   		Gossip.update(params['id'], params["gossip_author"], params["gossip_content"])
    	redirect '/'
	end

	get '/gossips/:id/comment' do 
    	erb :comment, locals: {hash_comment: Gossip.all_comments}
 	 end

 	post '/gossips/:id/comment/' do
   		Gossip.comment_gossip(params['id'], params["gossip_comment"])
    	redirect '/'
	end

end