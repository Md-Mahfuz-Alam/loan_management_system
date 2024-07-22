class AdminsController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_admin

  def index
    @loans = Loan.requested
  end

  def edit
    @interest_rate = Loan.find(params[:id]).interest_rate
    respond_to do |format|
      format.js
    end
  end

  def update
    @loan = Loan.find(params[:id])
    if @loan.update(state: 'approved', approved_by_id: current_user.id,  interest_rate: params[:admin_interest_rate].present? ? params[:admin_interest_rate] : params[:interest_rate])
      redirect_to admins_path, flash: { notice: 'Loan Approved Sucessfully.' }
    else
      redirect_to root_path, flash: { notice: 'Something went wrong' }
    end
  end

  def reject_loan
    @loan = Loan.find(params[:id])
    if @loan.update(state: 'rejected', rejected_by_id: current_user.id)
      redirect_to admins_path, flash: { notice: 'Loan rejected.' }
    else
      redirect_to root_path, flash: { notice: 'Something went wrong, Unable to reject loan' }
    end
  end

  def active_loans
    @loans = Loan.where(state: "open")
  end

  def closed_loans
    @loans = Loan.where(state: "closed")
  end
end
