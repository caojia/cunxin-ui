class Admin::ItemsController < ApplicationController
  ITEMS = %w(project carousel photo project_photo support account charities)

  before_filter :set_klass, :except => :index

  def index
    @items = ITEMS.map do |item|
      {
        :name => item,
        :count => Object.const_get(item.singularize.classify).count
      }
    end
  end

  def show
    @items = @klass.find(:all)
  end

  def new
    @item = @klass.new
  end

  def create
    @item = @klass.new(params[@klass.to_s.tableize.singularize])
    if @item.save
      flash[:success] = "Create #{@klass.to_s} successfully, id=#{@item.id}"
      redirect_to :action => :show, :id => params[:item_type], :item_type => params[:item_type]
    else
      flash[:error] = "Error occurs during #{@klass.to_s} creation"
      render :action => :new
    end
  end

  def edit
    @item = @klass.find(params[:id])
  end

  def update
    @item = @klass.find(params[:id])
    if @item.update_attributes(params[@klass.to_s.tableize.singularize])
      flash[:success] = "Update #{@klass.to_s} successfully, id=#{@item.id}"
      redirect_to :action => :show, :item_type => params[:item_type]
    else
      flash[:error] = "Error occurs during #{@klass.to_s} creation"
      render :action => :edit
    end
  end

  def delete
    @item = @klass.find(params[:item_id])
    @item.destroy
    redirect_to :action => :show, :item_type => params[:item_type]
  end

  private
    def set_klass
      @klass = Object.const_get(params[:item_type].singularize.classify)
    end

end
