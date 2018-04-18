class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :stripe_customer_id, null: false
      t.timestamps
    end
  end
end
