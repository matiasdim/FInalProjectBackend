class ReportsController < ApplicationController
  protect_from_forgery except: [:create, :update]

  # GET /reports
  # GET /reports.json

  def index
    if !params[:email].nil?
      reports = Report.where(user_email: params[:email])
      if reports
        render json: reports, status: :ok
      else
        render json: {message: 'There are no reports to show'}, status: :ok
      end
    else
      render json: {message: 'Please provide user email and try again'}, status: :bad_request
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show

    if !params[:id].nil?
      report = Report.find_by_id(params[:id])
      if report
        render json: report, status: :ok
      else
        render json: {message: 'Report doesn\'t exist'}, status: :bad_request
      end
    else
      render json: {message: 'There was an error getting report detail, please try it again'}, status: :bad_request
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    if !params[:reporter_name].nil? && !params[:pet_id].nil? && (!params[:reporter_cel].nil? || !params[:reporter_phone].nil? || !params[:reporter_email].nil? || !params[:reporter_observations].nil?)
      pet = Pet.find_by_id(params[:pet_id])
      if pet
        report = pet.reports.create(reporterName: params[:reporter_name],
                                    reporterCel: params[:reporter_cel],
                                    reporterPhone: params[:reporter_phone],
                                    reporterEmail: params[:reporter_email],
                                    reporterObservations: params[:reporter_observations],
                                    user_email: pet.user.email)
        if report
          render json: report, include: :pet, status: :created #with user render json: report, :include => {:pet => {:include => :user}}, status: :created
        else
          render json: {message: 'There was an error saving report, please try it again'}, status: :bad_request
        end
      else
        render json: {message: 'There was an error saving report, please try it again'}, status: :bad_request
      end
    else
      render json: {message: 'There are some parameters missing'}, status: :bad_request
    end
  end
end
