class InterestCalculatorJob 
  include Sidekiq::Worker

  queue_as :default

  def perform(loan_id)
    return unless Loan.exists?(loan_id)
    loan = Loan.find(loan_id)
    if loan.state == "open"
      loan.amount_with_interest += loan.amount_with_interest * (loan.interest_rate / 100.0)
      loan.save!
    end
    InterestCalculatorJob.perform_in(1.minute, loan_id) 
  end
end
