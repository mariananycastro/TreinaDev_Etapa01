class HomeController < ApplicationController
    def index
        if headhunter_signed_in?
            render :homehh 
        elsif job_seeker_signed_in?
            render :homejs
        end
    end    
end
