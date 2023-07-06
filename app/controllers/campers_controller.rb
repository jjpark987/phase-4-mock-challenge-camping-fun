class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Camper.all
    end

    def show
        render json: Camper.find(params[:id]), serializer: CamperActivitiesSerializer
    end

    def create 
        render json: Camper.create!(camper_params), status: :created
    end

    private

    def record_not_found 
        render json: { error: 'Camper not found' }, status: :not_found
    end

    def record_invalid e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def camper_params
        params.permit(:name, :age)
    end
end
