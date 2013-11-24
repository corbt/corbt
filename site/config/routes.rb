Site::Application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'landing'
  get '478', to: 'machine_learning#show'
  get '478/:region', to: 'machine_learning#aggregate_data'

  scope '/don' do
    get '', to: 'don_corbitt#show'
    get 'threads/by_list/:list_id', to: 'don_corbitt#get_threads_by_list'
    get 'posts/by_thread/:thread_id', to: 'don_corbitt#get_posts_by_thread'
  end
end
