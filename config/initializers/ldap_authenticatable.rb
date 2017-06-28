require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        if params[:user]
          unless password==''
            ldap = Net::LDAP.new
            ldap.host = 'dc.dvfu.ru'
            ldap.port = 389
            ldap.auth ENV['ldap_login'], ENV['ldap_password']
            if ldap.bind
              treebase = "dc=dvfu,dc=ru"
              if /^.+?@(students\.|)dvfu.ru$/i===login
                login.slice!(/@(students\.|)dvfu.ru$/i)
              end
              filter = Net::LDAP::Filter.eq( "cn", login)

              ldap.search( :base => treebase, :filter => filter ) do |entry|
                user_dn = entry.dn
                if entry[:mail].present?
                  user_email = entry.mail.first 
                  ldap.auth user_dn, password
                  if ldap.bind
                    user = User.find_by(username: login, email: user_email, ldap_user: true)
                    unless user
                      user=User.new(username: login, email: user_email, ldap_user: true)
                      user.save!(validate: false)
                    end
                    success!(user)
                  else
                    return fail(:invalid_login)
                  end
                else
                  return fail(:invalid_login)
                end
              end
            else
              return fail(:invalid_login)
            end
          else
            return fail(:invalid_login)
          end
        end
      end

      def login
        params[:user][:login]
      end

      def password
        params[:user][:password]
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)