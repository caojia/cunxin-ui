class HomeController < ApplicationController
  def index
    @carousels = Carousel.find(:all, :order => "position ASC", :include => :project)
    @charities = Charity.find(:all, :order => "name ASC")
  end
end
