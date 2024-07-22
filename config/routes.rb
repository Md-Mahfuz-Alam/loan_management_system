Rails.application.routes.draw do
  resources :loans do
    collection do
      get :rejected
      get :open_loan

    end
    member do
      get :requested_loan
      get :pending_loan
    end
  end

  resources :wallets

  resources :users do
    member do
      post :confirm_loan
      post :reject_loan
    end
  end

  resources :sessions

  resources :admins  do
    collection do
      get :active_loans
      get :closed_loans
    end
    member do
      post :reject_loan
    end
  end

  root "sessions#new"
end
