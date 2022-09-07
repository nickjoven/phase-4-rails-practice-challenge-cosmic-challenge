class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActiveRecord::RecordInvalid, with: :render_422

    def index
        scientists = Scientist.all
        render json: scientists
    end

    def show
        scientist = Scientist.find_by!(id: params[:id])
        render json: scientist, serializer: ScientistWithMissionsSerializer
        # 404 fires if not found (!)
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: 201
        # 422 fires w/ error messages if not valid (!)
    end

    def update
        scientist = Scientist.find_by!(id: params[:id])
        scientist.update!(scientist_params)
        render json: scientist, status: 202
    end

    def destroy
        scientist = Scientist.find_by!(id: params[:id])
        scientist.destroy
        render json: {}, status: 204
    end



    ###### PRIVATE ######

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_404
        render json: { error: "Scientist not found" }, status: 404 
    end

    def render_422(exception)
        render json: { errors: exception.record.errors.full_messages }, status: 422
    end
end
