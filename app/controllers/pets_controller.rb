class PetsController < ApplicationController
  protect_from_forgery except: [:create, :update]

  # GET /pets
  # GET /pets.json
  def index
    if !params[:email].nil?
      user = User.find_by_email(params[:email])
      if user
        render json: user.pets, status: :ok
      else
        render json: {message: '**There was an error getting pets, please try it again'}, status: :bad_request
      end
    else
      render json: {message: '!!There was an error getting pets, please try it again'}, status: :bad_request
    end
  end

  # GET /pets/1
  # GET /pets/1.json
  def show

    if !params[:id].nil?
      pet = Pet.find_by_id(params[:id])
      if pet
        render json: pet, status: :ok
      else
        render json: {message: 'Pet doesn\'t exist'}, status: :bad_request
      end
    else
      render json: {message: 'There was an error getting pet detail, please try it again'}, status: :bad_request
    end
  end

  # POST /pets
  # POST /pets.json
  def create

    if !params[:name].nil? && !params[:email].nil?
      user = User.find_by_email(params[:email])
      if user
        pet = user.pets.create(name:params[:name], observations: params[:observations])
        if pet
          render json: pet, status: :created
        else
          render json: {message: 'There was an error saving pet, please try it again'}, status: :bad_request
        end
      else
        render json: {message: 'There was an error saving pet, please try it again'}, status: :bad_request
      end
    else
      render json: {message: 'Pet name not provided'}, status: :bad_request
    end
  end

end
