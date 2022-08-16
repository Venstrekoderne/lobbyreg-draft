class PeopleController < ApplicationController
  before_action :require_login, except: :show

  def show
    person_id = params[:id]
    @person = Person.includes(:organization).find(person_id)
    @meetings = Meeting
                  .joins(meeting_attendees: :person)
                  .where(meeting_attendees: { person: person_id })
                  .all
  end

  def new
    @organizations = Organization.all
    @person = Person.new
  end

  def create
    @organizations = Organization.all
    @person = Person.new(person_params.except(:email, :organization))
    organization = Organization.find_by(id: person_params[:organization])
    @person.organization = organization
    begin
      @person.transaction do
        Email.create(person: @person, email_address: person_params[:email])
        @person.save
      end

      if params[:calendar_id]
        if params[:provider] == "google"
          redirect_to new_gcal_event_path(calendar_id: params[:calendar_id], event_id: params[:event_id]) and return
        end
      end

      render :create
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :email, :organization)
  end
end
