module OfficeVibe
  class Group < BaseAPI
    has_many :users

    def self.find(group_id)
      get_raw("/groups?groupid=#{group_id}") do |parsed_data, response|
        data = parsed_data[:data]
        if data
          return OfficeVibe::Group.new(data)
        else
          raise OfficeVibe::Errors::GroupNotFoundException.new("Group #{group_id} could not be found remotely")
        end
      end
    end

    def add_users(emails, to_members=true)
      params = {groupid: name, emails: emails, toMembers: to_members, toManagers: !to_members}
      Group.post(:addUsers, params)
    end

    def remove_users(emails, from_members=true)
      params = {groupid: name, emails: emails, fromMembers: from_members, fromManagers: !from_members}
      Group.post(:removeUsers, params)
    end
  end
end
