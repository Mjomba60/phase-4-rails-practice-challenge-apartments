class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

    def index
        render json: Apartment.all, status: :ok
    end

    def show
        render json: Apartment.find(params[:id])
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def invalid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

    def apartment_params
        params.permit(:number)
    end
end
