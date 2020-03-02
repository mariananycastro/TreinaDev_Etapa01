class Api::V1::JobOpportunitiesController < Api::V1::ApiController

    #rescue raise a exception, e executa o metodo not_fount_erros
    
    def show
      @job_opportunity = JobOpportunity.find(params[:id])
      #render json: @job_opportunity
      render json: @job_opportunity.as_json(root: true)
      
      #,status: 200 #como padrao se deu certo
      
      #outros status
      #:ok = 200
      #:not_found
      #:created
      #:no_content
      #:bad_request
      #:unauthorized
      #:forbidden
      #:precondition_failed
      #:unprocessable_entity
      #:internal_server_error
      #:service_unavailable
    end

    def index
      @job_opportunities = JobOpportunity.all

      render json: @job_opportunities
      
      #ou render json: JobOpportunity.all
    end

    def create

      @headhunter = current_headhunter
      @job_opportunity = @headhunter.job_opportunities.build(params.permit(:name, :description, :habilities, :salary_range, :opportunity_level,
                                                                                                    :end_date_opportunity, :region))
      if @job_opportunity.valid?
        #valida se tem todas as informacoes necessarios p criar o objeto
          @job_opportunity.save!
        #valida se foi salvo, pode ter dado algum problema na hora de salvar no banco
          render json: @job_opportunity, status: 201    
      else 
        render json: { msg: 'Precondition Falled' }, status: 412
        #412 precondition falled, nao preencheu todos os campos
      end
    end

    def update
      @headhunter = current_headhunter
      @job_opportunity = JobOpportunity.find(params[:id])
      if @job_opportunity.update(params.permit(%i[name description habilities salary_range opportunity_level end_date_opportunity region]))
        render json: @job_opportunity, status: 200
      else 
        
        render json: { title: 'error', message: "Precondition Falled" }, status: 412

        #soh string vai procurar uma view da string
        #com formato ele espera o formato
        #plain, html, json passa um objeto e transforma em jsonprimeiro manda o conteudo
        #e posso colocar data: @objeto.as_json
        

        #render json: 'error', status: 412
      end
    end
    
    def destroy
      @job_opportunity = JobOpportunity.find(params[:id])
      if @job_opportunity.destroy
        render json: {message: "Job Opportunity delete with Successfully."}, status: 200
      end
    end

      private
      
      #def not_found_errors
       # render json: 'Not Found', status: :not_found
     # end

  end

