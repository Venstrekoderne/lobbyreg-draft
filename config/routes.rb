Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/google_oauth/connect', to: 'google_oauth#connect'
  get '/google_oauth/redirect', to: 'google_oauth#redirect'
  get '/google_oauth/callback', to: 'google_oauth#callback'
  get '/google_oauth/list_calendars', to: 'google_oauth#list_calendars'
  get '/google_oauth/calendar/:calendar_id/events',
      to: 'google_oauth#list_events',
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      as: 'gcal_events'


  get '/microsoft_oauth/connect', to: 'microsoft_oauth#connect'
  get '/microsoft_oauth/redirect', to: 'microsoft_oauth#redirect'
  get '/microsoft_oauth/callback', to: 'microsoft_oauth#callback'
  get '/microsoft_oauth/list_calendars', to: 'microsoft_oauth#list_calendars'
  get '/microsoft_oauth/calendar/:calendar_id/events',
      to: 'microsoft_oauth#list_events',
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      as: 'microsoft_events'


  root "google_oauth#connect"
end
