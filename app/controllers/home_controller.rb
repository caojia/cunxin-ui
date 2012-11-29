class HomeController < ApplicationController
  def index
    @carousels = Carousel.find(:all, :order => "position ASC", :include => :project)

    @summary = {
      :amount => Payment.sum(:amount, :conditions => {:status => Payment::STATUS_FINISH}).to_i,
      :charities_count => t("home.charity_links").length,
      :people_count => User.count,
      :projects_count => Project.count(:conditions => {:published => true})
    }

    @supports = Support.find(:all, :order => "position ASC", :include => :photo, :limit => 4 )
  end
end
