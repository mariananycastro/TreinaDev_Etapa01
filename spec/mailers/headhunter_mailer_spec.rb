require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe HeadhunterMailer, type: :mailer do
  context 'teste mailer headhunter' do
    it 'send email successfully' do
      headhunter = create(:headhunter, email: 'hh@test.com')
      job_seeker = create(:job_seeker)
      job_opportunity = create(:job_opportunity, headhunter_id: headhunter.id)
      subscription = create(:subscription, job_seeker_id: job_seeker.id, job_opportunity_id: job_opportunity.id)

      ActiveJob::Base.queue_adapter = :test
      email = HeadhunterMailer.welcome_email(headhunter, subscription)

      expect{ email.deliver_later }.to have_enqueued_job.on_queue('mailers')
      expect(email.subject).to eq 'teste'
      expect(email.body).to have_content 'email de teste'
      expect(email.body).to have_content (headhunter.email)
      expect(email.body).to have_content (job_opportunity.name)
      expect(email.body).to have_content (job_seeker.email)
      
    end

    # since we have config.action_mailer.delivery_method  set to :test in our :test.rb, all 'sent' emails are gathered into the ActionMailer::Base.deliveries array.
    it 'welcome is sent' do
      headhunter = create(:headhunter, email: 'hh@test.com')
      job_seeker = create(:job_seeker)
      job_opportunity = create(:job_opportunity, headhunter_id: headhunter.id)
      subscription = create(:subscription, job_seeker_id: job_seeker.id, job_opportunity_id: job_opportunity.id)

      expect {
        perform_enqueued_jobs do
            HeadhunterMailer.welcome_email(headhunter, subscription).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(HeadhunterMailer.deliveries.count).to eq 1
    end

    it 'welcome_email is sent to the right user' do
      headhunter = create(:headhunter, email: 'hh@test.com')
      job_seeker = create(:job_seeker)
      job_opportunity = create(:job_opportunity, headhunter_id: headhunter.id)
      subscription = create(:subscription, job_seeker_id: job_seeker.id, job_opportunity_id: job_opportunity.id)

      perform_enqueued_jobs do
          HeadhunterMailer.welcome_email(headhunter, subscription).deliver_later
      end
  
      mail = ActionMailer::Base.deliveries.last

      expect(mail.to[0]).to eq headhunter.email
    end
  end
end
