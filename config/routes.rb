Gvideos::Application.routes.draw do
  resources :videos do
    resources :comments
    match 'rate/:rate' => 'videos#rate', as: 'rate'
  end

  match 'waiting' => 'videos#index', waiting: true, as: 'videos_waiting'

  devise_for :users

  root :to => "videos#index"
end
