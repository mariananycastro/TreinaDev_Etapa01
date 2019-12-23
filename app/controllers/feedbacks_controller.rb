class FeedbacksController < ApplicationController

    def new
        @subscription = Subscription.find(params[:subscription_id])
        @feedback = Feedback.new
    end

    def create
        @subscription = Subscription.find(params[:subscription_id])
        @feedback = Feedback.new(params.permit(:title, :message))
        @feedback.save
        @subscription.update_attribute(:hh_answer, @feedback)
        flash[:alert] = 'Inscrição rejeitada. Feedback enviado com sucesso.'
        redirect_to job_opportunity_subscription_feedback_path(@subscription.job_opportunity, @subscription, @feedback)
    end

    def show
        @feedback = Feedback.find(params[:id])
    end

end