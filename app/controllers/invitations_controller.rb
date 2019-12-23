class InvitationsController < ApplicationController

    def new
        @subscription = Subscription.find(params[:subscription_id])
        @invitation = Invitation.new
    end

    def create
        @subscription = Subscription.find(params[:subscription_id])
        @invitation = Invitation.new(params.permit(:title, :message))
        @invitation.save
        @subscription.update_attribute(:hh_answer, @invitation)
        flash[:alert] = 'Proposta enviada com sucesso'
        redirect_to job_opportunity_subscription_invitation_path(@subscription.job_opportunity, @subscription, @invitation)
    end

    def show
        @invitation = Invitation.find(params[:id])
    end

end
