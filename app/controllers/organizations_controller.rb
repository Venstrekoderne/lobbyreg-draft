class OrganizationsController < ApplicationController
  before_action :require_login, except: :show

  def show
    organization_id = params[:id]
    @organization = Organization.find(organization_id)
    @people = Person.all.last(10)
    @meetings = Meeting.all.last(10)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params.except(:email_domain))
    begin
      @organization.transaction do
        email_domain = organization_params[:email_domain]
        unless email_domain.nil? || email_domain.empty?
          regex_str = "@#{Regexp.escape(organization_params[:email_domain])}$"
          OrganizationEmailMapping.create(regex: regex_str, organization: @organization)
        end
        @organization.save!
      end
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :logo, :email_domain)
  end
end
