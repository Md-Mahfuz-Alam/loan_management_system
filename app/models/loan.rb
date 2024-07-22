class Loan < ApplicationRecord
  STATES = %w[requested approved open closed rejected].freeze

   belongs_to :user

   before_create :add_interest_rate

  validates :principle_amount, presence: true, numericality: true
  validates :state, inclusion: { in: STATES } 

  scope :requested, -> { where(state: "requested") }
  scope :closed_loans, ->(user_id) { where(user_id: user_id, state: "closed") }
  scope :requested_loans, ->(user_id) { where(user_id: user_id, state: "requested") }
  scope :pending_loans, ->(user_id) { where(user_id: user_id, state: "approved") }
  scope :open_loans, ->(user_id) { where(user_id: user_id, state: "open") }
  scope :rejected_loans, ->(user_id) { where(user_id: user_id, state: "rejected") }


  private

  def add_interest_rate
    self.interest_rate = 5.0
  end
end
