class GoogleOauthController < ApplicationController

  def connect
  end

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!
    session[:google_calendar_authorization] = response

    redirect_to google_oauth_list_calendars_url
  end

  def list_calendars
    service = authorized_calendar_service
    @calendar_list = service.list_calendar_lists&.items
  end

  def list_events
    service = authorized_calendar_service
    calendar_id = params[:calendar_id]
    start_at = 1.year.ago

    @calendar_name = service.get_calendar(calendar_id).summary
    @event_list = service.list_events(calendar_id,
                                      time_min: start_at.to_datetime.rfc3339)&.items
  end


  private

  def authorized_calendar_service
    client = Signet::OAuth2::Client.new(client_options)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client.update!(session[:google_calendar_authorization])

    service
  end

  def client_options
    {
      client_id: Rails.application.credentials.google_calendar.client_id,
      client_secret: Rails.application.credentials.google_calendar.client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: google_oauth_callback_url
    }
  end
end
