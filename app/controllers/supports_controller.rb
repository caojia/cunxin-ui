class SupportsController < ApplicationController
  def index
    @supports = Support.find(:all, :order => :position, :include => [:photo])
  end
end
