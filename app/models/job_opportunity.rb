class JobOpportunity < ApplicationRecord
    validates :name, presence:true
    validates :description, presence:true
    validates :habilities, presence:true
    validates :salary_range, presence:true
    validates :opportunity_level, presence:true
    validates :end_date_opportunity, presence:true
    validates :region, presence:true
    validate :end_date_opportunity_must_be_greater_than_today

    belongs_to :headhunter
    has_many :subscriptions

    enum opportunity_level: {Estagiário:0, Júnior:5, Pleno:10, Sênior:15, Especialista:20, Diretor:25}

    def description_job_opportunity
        "#{name} #{opportunity_level} #{end_date_opportunity} #{region}"
    end

    

    def end_date_opportunity_must_be_greater_than_today  
        if end_date_opportunity.present? && end_date_opportunity <= Date.current
          errors.add(:end_date_opportunity, 'deve ser maior que data de hoje')    
        end    
    end
    
end
