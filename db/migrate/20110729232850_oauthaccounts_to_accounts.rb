class OauthaccountsToAccounts < ActiveRecord::Migration
  def self.up
    rename_table :oauth_accounts, :accounts
  end

  def self.down
    rename_table :accounts, :oauth_accounts
  end
end
