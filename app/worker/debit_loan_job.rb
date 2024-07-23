class DebitLoanJob
  include Sidekiq::Worker

  queue_as :default

  def perform(loan_id)
    loan = Loan.find_by(id: loan_id)
    return unless loan
    user = loan.user

    if loan.amount_with_interest > user.wallet.balance
      debit_amount = user.wallet.balance
      admin_user =  User.find_by(role: "admin")
      admin_user.wallet.update(balance: admin_user.wallet.balance + debit_amount)
      user.wallet.balance = 0
      user.wallet.save!
      loan.state = "closed"
      loan.save!
    end
  loan.update(state: 'closed') if loan.amount_with_interest <= 0
  DebitLoanJob.perform_in(1.minute, loan_id) if loan.amount_with_interest > 0
  end
end
