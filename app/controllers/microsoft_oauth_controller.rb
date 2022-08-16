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
    # response {
    # "token_type"=>"Bearer",
    #  "scope"=>"Calendars.Read Calendars.Read.Shared",
    #  "expires_in"=>"5253",
    #  "ext_expires_in"=>"5253",
    #  "expires_on"=>"1660638817",
    #  "not_before"=>"1660633263",
    #  "resource"=>"https://graph.microsoft.com",
    #  "access_token"=>
    #   "foo.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC82ODllZGNkZS1mYjYyLTQ0NjctYWVmMC0zYWZlNTM3ZDBhZDAvIiwiaWF0IjoxNjYwNjMzMjYzLCJuYmYiOjE2NjA2MzMyNjMsImV4cCI6MTY2MDYzODgxNywiYWNjdCI6MCwiYWNyIjoiMSIsImFpbyI6IkFVUUF1LzhUQUFBQUpJeC9BU2RoUTFyTTdMOWREVzFxTkQwQlRCV1NLVWZ0Ris4d2V5MjdIOHFJdTV3UDJVem9IZ0QyZDdmN3pPL1h4dC9ZUE1TZXFZZUZncE1IOG0yc1dBPT0iLCJhbXIiOlsicHdkIiwibWZhIl0sImFwcF9kaXNwbGF5bmFtZSI6IkxvYmJ5cmVnLm5vIiwiYXBwaWQiOiI2ZjAxM2M0Yy1mM2Q4LTRhZWYtOGQzMi04MTI2ZjZkMGIyYWUiLCJhcHBpZGFjciI6IjEiLCJmYW1pbHlfbmFtZSI6IkphY2tzb24iLCJnaXZlbl9uYW1lIjoiRGFuaWVsIiwiaWR0eXAiOiJ1c2VyIiwiaXBhZGRyIjoiODUuMTY2LjExOC41MCIsIm5hbWUiOiJEYW5pZWwgSmFja3NvbiIsIm9pZCI6IjAxNDhjZTg4LTUwNjctNDlmMC1hYTU0LTg0NTljMGUwYzM3YSIsInBsYXRmIjoiNSIsInB1aWQiOiIxMDAzMjAwMEJFNDNDQzBEIiwicmgiOiIwLkFYUUEzdHllYUdMN1owU3U4RHItVTMwSzBBTUFBQUFBQUFBQXdBQUFBQUFBQUFCMEFCQS4iLCJzY3AiOiJDYWxlbmRhcnMuUmVhZCBDYWxlbmRhcnMuUmVhZC5TaGFyZWQiLCJzaWduaW5fc3RhdGUiOlsia21zaSJdLCJzdWIiOiJ5R3p3RG5PR1d3VHBNWHJFcFdQWk9LZHY2cmV5My13VXVNMXBBNWUwbHRvIiwidGVuYW50X3JlZ2lvbl9zY29wZSI6IkVVIiwidGlkIjoiNjg5ZWRjZGUtZmI2Mi00NDY3LWFlZjAtM2FmZTUzN2QwYWQwIiwidW5pcXVlX25hbWUiOiJkYW5pZWwuamFja3NvbkBsbnUubm8iLCJ1cG4iOiJkYW5pZWwuamFja3NvbkBsbnUubm8iLCJ1dGkiOiJnN0NnZnplT0prUzFpcWVGUGhCNEFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyJiNzlmYmY0ZC0zZWY5LTQ2ODktODE0My03NmIxOTRlODU1MDkiXSwieG1zX3RjZHQiOjE1NDM0ODQzNTQsInhtc190ZGJyIjoiRVUifQ.d-UaZdOsmyXWtAsTMONPsWiy7dIZoK81-Szz7A3jT-EwRYayH-wUcswx0MwpwBSTS5JCMh3YcjKW97WnBgtgi0Glrm0k3c84TrUzOnzEYotlW213ZVjyTqb7V4kCnFOD1aZ7liADa8fWyUntTCIA5M4q5IvS-QCuI44afDxbII5uX8omH1AxzWRFXnIY9z0IGktGyEUc8nJ5CkTfUeO85Yk4ERmM3YvsmY6JQYsI-8OJ8YAFAEaGwRSGW3-MrQe_tE9IOpgDWENgU0zK1dyDeL7C0XxhEnQI8REUxFfanRlXYQT5lq_WI-6i_s862A3MBp5dckIti85BkAPlTYHntg",
    #  "refresh_token"=>
    #   "0.AXQA3tyeaGL7Z0Su8Dr-U30K0Ew8AW_Y8-9KjTKBJvbQsq50ABA.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P9NblniW-8zeuudEQjiggEvSzjx0mpJD5ByHjYwF8iD-iBuInLrZy_RVgZgWCukdz5ZUZIPPjMGK9pJxueOpwCnv1aDarwiP8FdgglmDUaWTnkEtcJV5WWan4MWVeSCwUvnOJCwjUXsgB4Gkjz3lZ2sWEvoJV6Smgt75vr_Efbm-phsA-ZueEAWv11xS7gn91vvbK9mLZungAcO5W4dMIQKeqbBQWk_aknjE24Lp9nUYVRkk18wt_EilLEB743kRCmxlMiaSgs6bfAC44eul03P6-LcHYx7S6l_2jZGCQGJk2Aytvck1yhQLoVX-m44E6Lf186rvCGpupJgfBhhQ0w-Is3N-WFwpfhSaTggsOnYgWAhWlZzL_q9W4d4U7fk4s-tTmAOQmkm2qw-9DsY6ZKegM-NO_74Vj-otAEnmNJv3womwPPjiN9eYVdD6pAz4Qg5YP6Jm1kg3j1GyvsI7vdGmc2CCNHV4-VaDu1vVJWcoLsdrED_hTEjI2tntxY6Cvr96LKYTUXseQvGzcXstWYYwOxJcbDPgNevZNotW3lUz1vZ8lm0dfsGzBSo-TQmdP3Pb2RIy08l2sslhRnrAUTC-H0NqiTzomQ7oxCszoLev6dkpQZFtAFXmgbgcIIGtehMQICzR9V-bo7cYl727Spk9BFc0_vkPmHu3B3zcCrrUesk72tR7_LGDGGOWXXJzVduM5bTK0pYKPLg04Xp6KvsuEzdw_5YsQg-Nka0DTcBgnuTZfiBanbnmlnOH0gUnzIrgPUX7fyryE9IcPk9Hb-gvThNn3olH32xi-3aSMcJu1r60Dcnc4kl9wtf-dvN9Q",
    #  "id_token"=>
    #   "eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJhdWQiOiI2ZjAxM2M0Yy1mM2Q4LTRhZWYtOGQzMi04MTI2ZjZkMGIyYWUiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC82ODllZGNkZS1mYjYyLTQ0NjctYWVmMC0zYWZlNTM3ZDBhZDAvIiwiaWF0IjoxNjYwNjMzMjYzLCJuYmYiOjE2NjA2MzMyNjMsImV4cCI6MTY2MDYzNzE2MywiYW1yIjpbInB3ZCIsIm1mYSJdLCJmYW1pbHlfbmFtZSI6IkphY2tzb24iLCJnaXZlbl9uYW1lIjoiRGFuaWVsIiwiaXBhZGRyIjoiODUuMTY2LjExOC41MCIsIm5hbWUiOiJEYW5pZWwgSmFja3NvbiIsIm9pZCI6IjAxNDhjZTg4LTUwNjctNDlmMC1hYTU0LTg0NTljMGUwYzM3YSIsInJoIjoiMC5BWFFBM3R5ZWFHTDdaMFN1OERyLVUzMEswRXc4QVdfWTgtOUtqVEtCSnZiUXNxNTBBQkEuIiwic3ViIjoiRnhtemdpQ3pWM0kyRFRTUlVkOEVjc2ZxYTM3UFl4RXFwcXVwU3lGc3dXUSIsInRpZCI6IjY4OWVkY2RlLWZiNjItNDQ2Ny1hZWYwLTNhZmU1MzdkMGFkMCIsInVuaXF1ZV9uYW1lIjoiZGFuaWVsLmphY2tzb25AbG51Lm5vIiwidXBuIjoiZGFuaWVsLmphY2tzb25AbG51Lm5vIiwidmVyIjoiMS4wIn0."}
    # }
    session[:microsoft_calendar_authorization] = response

    redirect_to microsoft_oauth_list_calendars_url
  end

  def list_calendars
    @calendar_list = get_calendars
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

  def get_calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:microsoft_calendar_authorization])
    debugger
  end

  def authorized_calendar_service
  end


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
