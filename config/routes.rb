Rails.application.routes.draw do
  default_url_options host: 'caturl.ml'
  root to: 'shortener#index'
  get '/:id', to: 'shortener#show', as: :short_url
  post '/', to: 'shortener#create'
end
