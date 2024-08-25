Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :posts do
    resources :comments, only: %i[create update destroy]
  end
end
