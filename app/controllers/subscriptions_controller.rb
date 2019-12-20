 class SubscriptionsController < ApplicationController
    before_action :authenticate_job_seeker!

    def index
        @job_seeker = current_job_seeker
        @job_seeker_subscriptions = @job_seeker.subscriptions
    end

end
