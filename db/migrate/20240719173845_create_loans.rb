class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.decimal :principle_amount
      t.decimal :amount_with_interest
      t.decimal :interest_rate
      t.string :state
      t.references :user, null: false, foreign_key: true
      t.bigint :approved_by_id
      t.bigint :rejected_by_id

      t.timestamps
    end
  end
end
