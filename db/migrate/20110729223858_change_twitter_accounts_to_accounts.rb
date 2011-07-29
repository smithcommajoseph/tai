class ChangeTwitterAccountsToAccounts < ActiveRecord::Migration
  def self.up
    rename_table :twitter_accounts, :oauth_accounts
  end

  def self.down
    rename_table :oauth_accounts, :twitter_accounts
  end
end
