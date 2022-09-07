class MissionsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_422

    def create
        m = Mission.create!(mission_params)
        render json: m.planet, status: 201
    end

    ###### PRIVATE ######

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

    def render_422(exception)
        render json: { errors: exception.record.errors.full_messages }, status: 422
    end

end
