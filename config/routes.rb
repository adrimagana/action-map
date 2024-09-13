# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    get '/login' => 'login#login', :as => :login
    get '/login/google', to: redirect('auth/google_oauth2'), as: :google_login
    get '/login/github', to: redirect('auth/github'), as: :github_login
    get '/auth/google_oauth2/callback', to: 'login#google_oauth2', as: :google_oauth2_callback
    get '/auth/github/callback', to: 'login#github', as: :github_callback
    get '/logout' => 'login#logout', :as => :logout
    get '/user/profile', to: 'user#profile', as: :user_profile

    root to: 'map#index', as: 'root'
    get '/state/:state_symbol' => 'map#state', :as => :state_map
    get '/state/:state_symbol/county/:std_fips_code' => 'map#county', :as => :county

    get '/ajax/state/:state_symbol' => 'ajax#counties'

    # Routes for Events
    resources :events, only: %i[index show]
    get '/my_events/new' => 'my_events#new', :as => :new_my_event
    match '/my_events/new', to: 'my_events#create', via: [:post]
    get '/my_events/:id' => 'my_events#edit', :as => :edit_my_event
    match '/my_events/:id', to: 'my_events#update', via: %i[put patch]
    match '/my_events/:id', to: 'my_events#destroy', via: [:delete]

    # Routes for Representatives
    resources :representatives, only: [:index]
    resources :representatives do
        resources :news_items, only: %i[index show]

        # iter2 -- begin
        get '/representatives/:representative_id/my_news_item/search' => 'my_news_items#search', 
          :as   => :search_article
        get '/representatives/:representative_id/my_news_item/select' => 'search#news_select',
          :as => 'select_article'

        post '/representatives/:representative_id/my_news_item/save' => 'my_news_items#save',
         :as => 'save_article'
        
        get '/representatives/:representative_id/delete/:id', to:  'my_news_items#destroy',
          as: 'delete_article'  
        # iter2 -- end

        get '/representatives/:representative_id/my_news_item/result', to: 'my_news_items#result', as: :my_news_item_result
        get '/representatives/:representative_id/my_news_item/new' => 'my_news_items#new',
            :as                                                    => :new_my_news_item
        match '/representatives/:representative_id/my_news_item/new', to:  'my_news_items#create',
                                                                      via: [:post]
        match '/representatives/:representative_id/my_news_item/new', to:  'my_news_items#index',
                                                                      via: %i[put patch]
        get '/representatives/:representative_id/my_news_item/:id' => 'my_news_items#edit',
            :as                                                    => :edit_my_news_item
        match '/representatives/:representative_id/my_news_item/:id', to:  'my_news_items#update',
                                                                      via: %i[put patch]
        match '/representatives/:representative_id/my_news_item/:id', to:  'my_news_items#destroy',
                                                                      via: [:delete]
                                                                  
    end
    get '/search/(:address)' => 'search#search', :as => 'search_representatives'
    # newly added -- iter2
    get '/linkto' => 'my_news_items#article_url',
      :as => :article_url
end

