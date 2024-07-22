class UpdateLoansTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :loans, :state
    add_column :loans, :state, :string, default: 'requested', null: false

    # Add new indexes
    add_index :loans, :approved_by_id, name: 'index_loans_on_approved_by_id'
    add_index :loans, :rejected_by_id, name: 'index_loans_on_rejected_by_id'
  end
end
