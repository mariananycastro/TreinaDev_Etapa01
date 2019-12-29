class HomeController < ApplicationController
    def index
        if headhunter_signed_in?
            @headhunter = current_headhunter
            @job_opportunities = @headhunter.job_opportunities.find_by(headhunter:@headhunter)
            @hh_subscriptions = Subscription.where(job_opportunity:@job_opportunities)
            render :homehh 
        elsif job_seeker_signed_in?
            @subscriptions = Subscription.where(job_seeker:current_job_seeker)
            render :homejs

        end
    end    
end
