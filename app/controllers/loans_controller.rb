class LoansController < ApplicationController
  before_action :require_user_logged_in

  def index
    @loans = Loan.closed_loans(current_user.id)
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan =  Loan.new(loan_params)
    @loan.user_id = current_user.id
    if @loan.save
      @loan.update(amount_with_interest: loan_params["principle_amount"])
      redirect_to requested_loan_loan_path(@loan), flash: { notice: 'Loan request created.' }
    else
      flash[:notice] = "Something went wrong"
      render :new
    end
  end

  def requested_loan
    @loans = Loan.requested_loans(current_user.id)

  end

  def pending_loan
    @loans = Loan.pending_loans(current_user.id)
  end

  def open_loan
    @loans = Loan.open_loans(current_user.id)
  end

  def update
    @loan = Loan.find(params[:id])
    if current_user.wallet.balance >= @loan.amount_with_interest
      current_user.wallet.update(balance: current_user.wallet.balance - @loan.amount_with_interest)
      @user =  User.find_by(role: "admin")
      @user.wallet.update(balance: @user.wallet.balance + @loan.amount_with_interest)
      @loan.update(state: 'closed')
      redirect_to open_loan_loans_path, flash: { notice: 'Loan repaid successfully.' }
    else
      redirect_to open_loan_loans_path, flash: { notice: 'Insufficient balance to repay the loan.' }
    end
  end

  def rejected
    @loans = Loan.rejected_loans(current_user.id)
  end

  def destroy
    @loan = Loan.find_by(id: params[:id])
    @loan.destroy
    redirect_to requested_loan_loan_path, flash: { notice: 'Loan deleted successfully.' }
  end

  private

  def loan_params
    params.require(:loan).permit(:principle_amount)
  end
end
