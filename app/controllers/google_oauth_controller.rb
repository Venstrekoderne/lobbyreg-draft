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
    oauth2_service = authorized_userinfo_service response
    userinfo = oauth2_service.get_userinfo

    allowed_syncer = AllowedSyncer.find_by(email: userinfo.email)
    if allowed_syncer.nil?
      render :forbidden and return
    end

    session[:syncer_name] = userinfo.name.dup
    session[:google_calendar_authorization] = response
    auto_login(allowed_syncer)

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

  def new_event
    service = authorized_calendar_service
    calendar_id = params[:calendar_id]
    event_id = params[:event_id]

    @meeting = service.get_event(calendar_id, event_id)
    if @meeting.nil?
      render :event_not_found
    end

    @unknown_people = @meeting.attendees
                              .map { |x|
                                if Email.find_by(email_address: x.email).nil?
                                  x
                                end
                              }
                              .filter { |x| !x.nil? }
    @known_people = @meeting.attendees
                              .map { |x|
                                email = Email.find_by(email_address: x.email)
                                unless email.nil?
                                  {person: email.person, email: x.email}
                                end
                              }
                              .filter { |x| !x.nil? }
  end


  private

  def authorized_userinfo_service(token)
    client = Signet::OAuth2::Client.new(client_options)
    service = Google::Apis::Oauth2V2::Oauth2Service.new
    service.authorization = client.update!(token || session[:google_calendar_authorization])

    service
  end

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
      scope: [
        Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
        Google::Apis::Oauth2V2::AUTH_USERINFO_EMAIL,
        Google::Apis::Oauth2V2::AUTH_USERINFO_PROFILE,
      ],
      redirect_uri: google_oauth_callback_url
    }
  end
end
