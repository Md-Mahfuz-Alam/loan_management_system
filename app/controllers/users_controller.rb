class UsersController < ApplicationController

  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to new_session_path, flash: { notice: 'Signed up successfully' }
    else  
      flash[:notice] = 'Something went wrong'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
