class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    # GET /activities
    def index
        activities= Activity.all 
        render json: activities
    end

    # GET /activity/:id
    # def show
    #     activity=Activity.find(params[:id])
    #     render json: activity
    # end


    # DELETE /activity/:id
    def destroy
        activity=Activity.find(params[:id])
        activity.destroy
        head :no_content
    end

    private
    def activity_params
        params.permit(:name, :difficulity)
    end

    def render_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
