Gvideos::Application.routes.draw do
  resources :videos do
    resources :comments
    match 'rate' => 'videos#rate', as: 'rate', via: :post
  end

  match 'waiting' => 'videos#index', waiting: true, as: 'videos_waiting', via: :get

  devise_for :users

  root :to => "videos#index"
end
