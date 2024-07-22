class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[ reject_loan confirm_loan show ]


  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role="user"

    if @user.valid?
      @user.save
      Wallet.create(balance: 10000, user: @user)
      redirect_to new_session_path, flash: { notice: 'Signed up successfully' }
    else  
      flash[:notice] = 'Something went wrong'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @wallet_balance = @user.wallet&.balance.to_i
    @open_loan = Loan.open_loans(current_user.id).count
    @closed_loan = Loan.closed_loans(current_user.id).count
  end


  def reject_loan
    @loan = Loan.find(params[:id])
    if @loan.update(state: 'rejected')
      redirect_to root_path, flash: { notice: 'Loan rejected.' }
    else
      redirect_to root_path, flash: { notice: 'Unable to reject loan.' }
    end
  end
  def confirm_loan
    @loan = Loan.find(params[:id])
    @admin_user =  User.find_by(role: "admin")
    if @loan.update(state: 'open') &&  @admin_user.wallet.balance >= @loan.principle_amount
      @loan.user.wallet.update(balance: @loan.user.wallet.balance + @loan.principle_amount)
      @admin_user.wallet.update(balance: @admin_user.wallet.balance - @loan.principle_amount)
      InterestCalculatorJob.perform_async(@loan.id)
      DebitLoanJob.perform_async(@loan.id)
      redirect_to root_path, flash: { notice:  'Loan confirmed and amount_with_interest credited to your wallet.' }
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
