class CharitiesController < ApplicationController
  def show
    @charity = Charity.find(params[:id], :include => [:projects] )
  end
end
