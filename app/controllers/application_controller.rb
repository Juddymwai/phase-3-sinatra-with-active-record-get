class ApplicationController < Sinatra::Base

  set :default_content_type, "application/json"
  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    #get all the games from the db
    games = Game.all.order(:title).limit(10)    #sorting by title

    #return a JSON response of all data
    games.to_json
  end

  get '/games/:id' do
    #look up the game in the db using its ID
    game = Game.find(params[:id])

    #send a jSON respond of the game data
    game.to_json
    game.to_json(include: :reviews)   #includes reviews 
    game.to_json(include: {reviews: {include: :user}})    # includes users asscoiated with each review

    #selecting which attributes to be returned in each model
    game.to_json(only: [:id, :title, :genre, :price], include: {reviews: {only: [:comment, :score], include: {user: {only: [:name]}}}})
  end

end
