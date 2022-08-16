class SearchController < ApplicationController
  def index
    # Front page
    @organizations = Organization.all
    @meetings = Meeting.all.last(10)
    @people = Person.includes(:organization).all
  end
end
