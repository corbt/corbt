Site::Application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'landing'
  get '478', to: 'machine_learning#show'
  get '478/:region', to: 'machine_learning#aggregate_data'
end
