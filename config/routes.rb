Rails.application.routes.draw do
  post '/board'   => 'boards#create'
  delete '/board' => 'boards#destroy'
  get '/status'   => 'boards#playing'
  patch '/play'   => 'boards#play'
  patch '/flag'   => 'boards#flag'
end
