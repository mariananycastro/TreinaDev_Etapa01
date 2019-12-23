class FeedbacksController < ApplicationController
    before_action :authenticate_headhunter!, except: [:show]
    before_action :authenticate_headhunter_and_job_seeker, only: [:show]

    def new
        @subscription = Subscription.find(params[:subscription_id])
        @feedback = Feedback.new
    end

    def create
        @subscription = Subscription.find(params[:subscription_id])
        @feedback = Feedback.new(params.permit(:title, :message))
        @feedback.save
        @subscription.update(hh_answer:@feedback, status:'rejected')
        flash[:alert] = 'Inscrição rejeitada. Feedback enviado com sucesso.'
        redirect_to job_opportunity_subscription_feedback_path(@subscription.job_opportunity, @subscription, @feedback)
    end

    def show
        @feedback = Feedback.find(params[:id])
    end

    private

    def authenticate_headhunter_and_job_seeker
        :authenticate_headhunter! || :authenticate_job_seeker!
    end

end