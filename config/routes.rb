Rails.application.routes.draw do
  resources :nfts
  resources :invoices
  resources :wallets

  get '/nft_contracts', to: 'nfts#contracts'
  get '/mint_nft', to: 'nfts#mint_nft'
  get '/transfer_nft', to: 'nfts#transfer_nft'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
