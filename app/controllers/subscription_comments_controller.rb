
class SubscriptionCommentsController < ApplicationController
    before_action :authenticate_headhunter!

    def new
        @subscription = Subscription.find(params[:subscription_id])
        @job_opportunity = @subscription.job_opportunity
        @subscription_comment = SubscriptionComment.new
    end

    def create
        @subscription = Subscription.find(params[:subscription_id])
        @subscription_comment = @subscription.build_subscription_comment(params.require(:subscription_comment).permit(:comment))
        if @subscription_comment.save
            redirect_to job_opportunity_subscription_subscription_comment_path(
                        @subscription.job_opportunity, @subscription, @subscription_comment)
        end
    end 

    def show
        @subscription_comment = SubscriptionComment.find(params[:id])
        @subscription = @subscription_comment.subscription
        @profile_description = @subscription.job_seeker.profile.job_seeker_profile
        @job_opportunity_description = @subscription.job_opportunity.description_job_opportunity
    end

    def edit
        @subscription_comment = SubscriptionComment.find(params[:id])
        @subscription = @subscription_comment.subscription
        @job_opportunity = @subscription.job_opportunity
    end 

    def update
        @subscription_comment = SubscriptionComment.find(params[:id])
        @subscription = @subscription_comment.subscription
        @subscription_comment.update(params.require(:subscription_comment).permit(:comment))
        redirect_to job_opportunity_subscription_subscription_comment_path(
                        @subscription.job_opportunity, @subscription, @subscription_comment)
    end 

    def destroy
        @subscription_comment = SubscriptionComment.find(params[:id])
        @subscription = @subscription_comment.subscription
        @subscription_comment.delete    
        redirect_to  profile_path(@subscription.job_seeker.profile)
    end




end
