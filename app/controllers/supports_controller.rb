class SupportsController < ApplicationController
  def index
    @page = (params[:page] || '1').to_i
    @supports = Support.find(:all, :order => :position, :include => [:photo],
                             :limit => 10, :offset => 10*(@page-1))
  end
end
