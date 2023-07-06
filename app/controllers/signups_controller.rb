class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end

    private

    def record_invalid e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end
end
