# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :form_submissions, only: [:create, :show]

  resources :forms do
    resources :form_submissions, only: :index

    member do
      patch :publish
      get :view
    end
  end

  get 'error', to: 'pages#error'
  root 'forms#index'
end
