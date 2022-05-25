Rails.application.routes.draw do
  get 'minesweeper/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'minesweeper#index'

  post '/board'   => 'boards#create'
  delete '/board' => 'boards#destroy'
  get '/status'   => 'boards#playing'
  patch '/play'   => 'boards#play'
  patch '/flag'   => 'boards#flag'
end
