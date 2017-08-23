Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/company/:name' => 'paranuara#company'
  get '/people' => 'paranuara#people'
  get '/person/:index' => 'paranuara#person'

end
