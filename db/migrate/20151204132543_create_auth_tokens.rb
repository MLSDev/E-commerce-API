class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :value
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
