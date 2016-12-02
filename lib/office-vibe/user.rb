module OfficeVibe
  class User < BaseAPI
    primary_key :email

    def self.deactivate(email)
      User.post(:deactivate, {email: email})
    end
  end
end
