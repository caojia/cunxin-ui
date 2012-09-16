class HomeController < ApplicationController
  def index
    @carousels = Carousel.find(:all, :order => "position ASC", :include => :project)
    @charities = Charity.find(:all, 
                              :order => "id ASC", 
                              :conditions => ["published = ?", true])
    @consults = Consult.find(:all,
                             :order => "id ASC",
                             :conditions => ["published = ?", true])
    @donators = Donator.find(:all,
                             :order => "id ASC",
                             :conditions => ["published = ?", true])

    @summary = {
      :amount => 223101,
      :charities_count => 21,
      :people_count => 23110,
      :projects_count => 40
    }
  end
end
