require "profiles/version"
require "profiles/profiles_udid_fetcher"

class ProfilesUtils
  
  def self.search_local_provisions(udid, include_team_profiles)
    fetcher = ProfilesUDIDFetcher.new(profiles:self.local_provision_files,
                                      udid:udid,
                                      include_team_profiles:include_team_profiles)
    fetcher.provision_profiles                                  
  end
  
  def self.local_provision_files
    Dir["#{provision_directory_path}/*"].grep (/.*.mobileprovision/)
  end

  private 
  
  def self.provision_directory_path
    "#{ENV["HOME"]}/Library/MobileDevice/Provisioning Profiles"
  end
  
end

