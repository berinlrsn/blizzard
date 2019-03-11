Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :reading, only: [:create, :show] do
    get :stats
  end
end
