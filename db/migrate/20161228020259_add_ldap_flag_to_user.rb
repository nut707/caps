class AddLdapFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :ldap_user, :boolean, null: false, default: false
  end
end
