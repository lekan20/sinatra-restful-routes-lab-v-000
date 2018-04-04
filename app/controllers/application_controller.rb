class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do #prints out all the recipes on the index page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do #pulls up the form to create a new recipe
    erb :new
  end

  post '/recipes' do #Adds the new form to the database and posts it to the id's page
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    #find the recipe by the id added to the dynamic route
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #load action
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  post '/recipes/:id' do #edit action
    require 'pry'
    # binding.pry
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end


end
