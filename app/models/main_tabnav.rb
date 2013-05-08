class MainTabnav < Tabnav::Base    
       

    add_tab do 
      named 'OWNERS'
      links_to :controller => 'owners'
    end
    
    add_tab do 
      named 'EVENTS'
      links_to :controller => 'events'
    end 

    add_tab do 
      named 'REPORTING'
      links_to :controller => 'reporting'
    end
    
    add_tab do 
      named 'Riders'
      links_to :controller => 'riders'
    end    
    
    add_tab do 
      named 'Horses'
      links_to :controller => 'horses'
    end    
    
    add_tab do 
      named 'Event Participants'
      links_to :controller => 'event_participants'
    end    

end