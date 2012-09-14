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
  end
end
