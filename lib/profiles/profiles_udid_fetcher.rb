require "profiles/provision_profile_parser"

class ProfilesUDIDFetcher
  
  def initialize(profiles:profiles, udid:udid, include_team_profiles:include_team_profiles)
    @udid = udid
    @include_team_profiles = include_team_profiles
    @provision_profiles = profiles
  end

  def provision_profiles
    profiles_containing_udid
  end

  private

  def profiles_containing_udid
    profiles = []
        
    @provision_profiles.each do |file|
      provision_profile = ProvisionProfileParser.new(file)
      
      devices = provision_profile.provisioned_devices
      
      next unless devices && devices.include?(@udid)
     
      profile_name = provision_profile.name
      next if profile_name =~ /iOSTeam Provisioning Profile.*/ && !@include_team_profiles
     
      profiles << profile_name
    end

    profiles
  end
end