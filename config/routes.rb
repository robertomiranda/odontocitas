Odontocitas::Application.routes.draw do

  resources :clinicas


  resources :doctor
  resources :medio_pagos
  resources :consulta
  resources :prepagadas
  resources :specialities
  resources :consultorios
  resources :horas_disponibles
  resources :odontologos


  get "welcome/index"
  get "welcome/show"

  #resources :horas_disponibles


  resources :appointments
  
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'semana', to: 'odontologos#semana', as:'semana'
  get 'cambiar_clave_odontologo', to: 'odontologos#cambiar_clave', as:'cambiar_clave_odontologo'
  get 'agendar', to: 'odontologos#agendar', as:'agendar'
  post 'agendar', to: 'odontologos#agendar', as:'agendar'
  get 'citas_odontologo', to: 'odontologos#citas_odontologo', as:'citas_odontologo'
  get 'pacientes_odontologo', to: 'odontologos#pacientes_odontologo', as:'pacientes_odontologo'
  get 'perfil_odontologo', to: 'odontologos#perfil', as:'perfil_odontologo'
  get 'mes', to: 'odontologos#mes', as:'mes'
  get 'disponibilidad', to: 'odontologos#disponibilidad', as:'disponibilidad'
  get 'buscar_odontologo', to: 'welcome#buscar_odontologo', as:'buscar_odontologo'
  get 'quitar_horas_disponibles', to: 'odontologos#quitar_horas_disponibles', as:'quitar_horas_disponibles'
  get 'agendar_cita', to: 'doctor#agendar_cita', as:'agendar_cita'
  get 'agregar_odontologo', to: 'doctor#agregar_odontologo', as:'agregar_odontologo'
  get 'gracias_por_registrarte', to: 'doctor#gracias_por_registrarte', as:'gracias_por_registrarte'
  get 'confirmar_cita', to: 'doctor#confirmar_cita', as:'confirmar_cita'
  get 'agregar_paciente', to: 'pacientes#agregar_paciente', as:'agregar_paciente'
  post 'enviar_mensaje', to: 'pacientes#enviar_mensaje', as:'enviar_mensaje'
  get 'clinica/:id', to: 'clinicas#mostrar', as: 'clinica'
  get 'recordar_clave', to: 'sessions#recordar_clave', as: 'recordar_clave'
  get 'restaurar_clave', to: 'sessions#restaurar_clave', as: 'restaurar_clave'

  #----Contacto
  get 'terminos_condiciones', to: 'welcome#terminos_condiciones', as: 'terminos_condiciones' 
  get 'politicas_privacidad', to: 'welcome#politicas_privacidad', as: 'politicas_privacidad'
  get 'nosotros', to: 'welcome#nosotros', as: 'nosotros'

  resources :sessions

  resources :pacientes


  resources :odontologos do
    resources :horas_disponibles
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
