class SubscriptionCommentsController < ApplicationController
    before_action :authenticate_headhunter!

    def new
        @job_seeker = 
        @job_opportunities = JobOpportunity.where(headhunter:current_headhunter)
        @subscriptions = Subscription.where(job_seeker:@job_seeker, job_opportunity:@job_opportunities)
        @subscription_comment = SubscriptionComment.new
    end

    def create
        @job_seeker = 
        @job_opportunities = JobOpportunity.where(headhunter:current_headhunter)
        @subscriptions = Subscription.where(job_seeker:@job_seeker, job_opportunity:@job_opportunities)  
        @subscription_comment = SubscriptionComment.create!(params.require(:subscription_comment).permit(:comment))
    end

end