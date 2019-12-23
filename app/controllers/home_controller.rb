class HomeController < ApplicationController
    def index
        if headhunter_signed_in?
            @headhunter = current_headhunter
            @job_opportunities = @headhunter.job_opportunities.find_by(headhunter:@headhunter)
            render :homehh 
        elsif job_seeker_signed_in?
            @job_seeker = current_job_seeker
            @subscriptions = Subscription.all
            render :homejs

        end
    end    
end
