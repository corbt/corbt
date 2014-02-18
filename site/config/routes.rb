Site::Application.routes.draw do
  root to: redirect('/about')
  get '/about', to: 'high_voltage/pages#show', id: 'about'
  get '/wedding', to: 'wedding#show'
  get '/boda', to: redirect('/wedding?locale=es')

  post '/catan/update', to: 'catan#update'

  scope '/don' do
    get '', to: redirect('/don/about')
    get 'about', to: 'don_corbitt#about'
    get 'posts', to: 'don_corbitt#posts'
    get 'threads/by_list/:list_id', to: 'don_corbitt#get_threads_by_list'
    get 'posts/by_thread/:thread_id', to: 'don_corbitt#get_posts_by_thread'
  end
end
