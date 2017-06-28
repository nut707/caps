# Devise::Models::LdapAuthenticatable::ClassMethods.class_eval do
#   def find_for_ldap_authentication(attributes={})
#     # auth_key = self.authentication_keys.first
#     auth_key = :username
#     return nil unless attributes[auth_key].present?

#     auth_key_value = (self.case_insensitive_keys || []).include?(auth_key) ? attributes[auth_key].downcase : attributes[auth_key]
#     auth_key_value = (self.strip_whitespace_keys || []).include?(auth_key) ? auth_key_value.strip : auth_key_value

#     resource = where(auth_key => auth_key_value).first

#     if resource.blank?
#       resource = new
#       resource[auth_key] = auth_key_value
#       resource.password = attributes[:password]
#     end

#     if ::Devise.ldap_create_user && resource.new_record? && resource.valid_ldap_authentication?(attributes[:password])
#       resource.ldap_before_save if resource.respond_to?(:ldap_before_save)
#       resource.save!
#     end

#     resource
#   end
# end