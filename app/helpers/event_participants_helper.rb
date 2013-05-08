module EventParticipantsHelper
  include AjaxScaffold::Helper
  
  def num_columns
    scaffold_columns.length + 1 
  end
  
  def scaffold_columns
    EventParticipant.scaffold_columns
  end
  
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
