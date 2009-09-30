class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :identity_url
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
