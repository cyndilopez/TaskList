Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  # get "/tasks", to: "tasks#index", as: "tasks"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create"
  # get "/tasks/:id", to: "tasks#show", as: "task"
  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  # patch "/tasks/:id", to: "tasks#update"
  # delete "/tasks/:id", to: "tasks#destroy"
  # post "/tasks/:id/complete", to: "tasks#complete", as: "complete_task"
  # post "/tasks/:id/incomplete", to: "tasks#incomplete", as: "incomplete_task"

  resources :tasks
  resources :tasks do
    post "complete", to: "tasks#complete", on: :member
    post "incomplete", to: "tasks#incomplete", on: :member
  end
end