class CharitiesController < ApplicationController
  def show
    @charity = Charity.find(params[:id], :include => [:projects] )
    @total_donated = 1000
  end
end
