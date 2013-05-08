# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  layout "layouts/main" 
  
  # if we have an owner in the session then filter to it.
  def filter_by_owner(array_to_filter)
    filtered_array = []
    if session[:owner]
      array_to_filter.each do |object|
        if object.owner == session[:owner]
          filtered_array << object
        end
      end
    else
      filtered_array = array_to_filter
    end
    filtered_array
  end
end