Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  get 'accounts/balance'
  post 'accounts/transfer'
  get 'accounts/statement'
end
