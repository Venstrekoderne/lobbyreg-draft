Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "google_oauth#connect"

  get '/people/new', to: 'person#new'
  post '/people/new', to: 'person#create', as: :people_create

  get '/organization/new', to: 'organization#new'
  post '/organization/new', to: 'organization#create', as: :organization_create

  get '/google_oauth/connect', to: 'google_oauth#connect'
  get '/google_oauth/redirect', to: 'google_oauth#redirect'
  get '/google_oauth/callback', to: 'google_oauth#callback'
  get '/google_oauth/list_calendars', to: 'google_oauth#list_calendars'
  get '/google_oauth/calendar/:calendar_id/events',
      to: 'google_oauth#list_events',
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      as: 'gcal_events'
  get '/google_oauth/calendar/:calendar_id/events/:event_id/new',
      to: 'google_oauth#new_event',
      as: "new_gcal_event",
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      event_id: /[^\/]+/ # Accept all characters except slashes for the id
  post '/google_oauth/calendar/:calendar_id/events/:event_id',
      to: 'google_oauth#create_event',
      as: "create_gcal_event",
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      event_id: /[^\/]+/ # Accept all characters except slashes for the id

  get '/microsoft_oauth/connect', to: 'microsoft_oauth#connect'
  get '/microsoft_oauth/redirect', to: 'microsoft_oauth#redirect'
  get '/microsoft_oauth/callback', to: 'microsoft_oauth#callback'
  get '/microsoft_oauth/list_calendars', to: 'microsoft_oauth#list_calendars'
  get '/microsoft_oauth/calendar/:calendar_id/events',
      to: 'microsoft_oauth#list_events',
      calendar_id: /[^\/]+/, # Accept all characters except slashes for the id
      as: 'microsoft_events'
end
