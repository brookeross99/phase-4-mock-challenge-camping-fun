class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    # GET /campers
    def index
        campers = Camper.all
        render json: campers
    end

    # GET /campers/:id
    # Will need to seralize and show activities for that camper
    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperDetailsSerializer
    end

    # POST /campers
    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private
    def render_not_found(exception)
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_invalid(invalid)
        render json: {"errors": invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
