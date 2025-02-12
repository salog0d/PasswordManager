class PasswordsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_password, except: [:index, :new, :create]
  
    def index
      @passwords = current_user.passwords
    end
  
    def new
      @password = Password.new
    end

    def show
        set_password
    end
  
    def create
      @password = current_user.passwords.create(password_params)
      if @password.persisted?  
        redirect_to @password, notice: "Password saved successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
        if @password.update(password_params)  
            redirect_to @password, notice: "Password updated successfully."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
      @password.destroy
      redirect_to root_path, notice: "Password deleted successfully."
    end
    private
  
    def password_params
      params.require(:password).permit(:url, :username, :password)
    end

    def set_password
        @password = current_user.passwords.find(params[:id])
    end
  end
  