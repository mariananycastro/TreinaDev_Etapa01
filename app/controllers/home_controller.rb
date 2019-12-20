class HomeController < ApplicationController
    def index
        if headhunter_signed_in?
            @headhunter = current_headhunter
            @job_opportunities = @headhunter.job_opportunities.find_by(headhunter:@headhunter)
            render :homehh 
        elsif job_seeker_signed_in?
            render :homejs
        end
    end    
end
