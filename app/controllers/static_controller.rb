class StaticController < ApplicationController
  before_filter :set_body_class

  protected
    def set_body_class
      @body_class = action_name
    end
end
