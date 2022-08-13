class MicrosoftOauthController < ApplicationController

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
    session[:microsoft_calendar_authorization] = response

    render response.to_s

    #redirect_to microsoft_oauth_list_calendars_url
  end

  def list_calendars
    service = authorized_calendar_service
    @calendar_list = service.list_calendar_lists
  end

  def list_events
    service = authorized_calendar_service
    calendar_id = params[:calendar_id]
    start_at = 1.year.ago

    @calendar_name = service.get_calendar(calendar_id).summary
    @event_list = service.list_events(calendar_id,
                                      time_min: start_at.to_datetime.rfc3339)
  end


  private


  def client_options
    {
      client_id: Rails.application.credentials.microsoft_calendar.client_id,
      client_secret: Rails.application.credentials.microsoft_calendar.client_secret,
      authorization_uri: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      token_credential_uri: "https://login.microsoftonline.com/common/oauth2/token",
      scope: ["https://graph.microsoft.com/Calendars.Read", "https://graph.microsoft.com/Calendars.Read.Shared"],
      redirect_uri: microsoft_oauth_callback_url
    }
  end
end
