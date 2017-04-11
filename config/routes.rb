Rails.application.routes.draw do

  root 'search#index'
  get 'results', to: 'search#results', as: 'results'

end
