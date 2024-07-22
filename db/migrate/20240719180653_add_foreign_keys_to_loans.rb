class AddForeignKeysToLoans < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :loans, :users, column: :approved_by_id
    add_foreign_key :loans, :users, column: :rejected_by_id
  end
end
