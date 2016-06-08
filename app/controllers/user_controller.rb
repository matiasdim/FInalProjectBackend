class UserController < ApplicationController

	protect_from_forgery except: [:create, :update]

	# Create user
	# POST /users/create
	def create

		if !params[:email].nil? && !params[:password].nil? && !params[:name].nil? && !params[:mobile].nil?
			user = User.new(:email => params[:email],
											:password => params[:password],
											:password_confirmation => params[:password],
											:name => params[:name],
											:mobile => params[:mobile])
			if user.save
				sign_in user, :bypass => true 
				render json: user, status: :created
			else
				render json: {message: 'User exists, or Password doesn\'t match'}, status: :not_found
			end
		else

			render json: {message: 'Username not found or Password don\'t provided'}, status: :bad_request
		end
	end

	# Login User
	# PUT /users/update
	def update
		if !params[:email].nil? && !params[:password].nil?
			user = User.find_by_email(params[:email])

			if user
			valid_password = user.valid_password?(params[:password])
				if valid_password
					if current_user?(user) && current_user.email == user.email
						render json: user, status: :accepted
					else
						if sign_in user, :bypass => true
							render json: user, status: :accepted
						end
					end
				else
					render json: {message: 'Invalid password'}, status: :unauthorized
				end
			else
				render json: {message: 'User not found'}, status: :not_found
			end
		else
			render json: {message: 'Username not found or Password don\'t provided'}, status: :bad_request
		end
	end

	private

	def current_user?(user)
		user == current_user
	end

end
