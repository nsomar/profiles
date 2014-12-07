require 'cfpropertylist'

TEMP_PLIST = "/tmp/tmp.plist"

class ProvisionProfileParser

  def initialize provision_path
    @provision_path = provision_path
    at_exit { clean_up }
  end

  def certificates
    parse
    @data["DeveloperCertificates"]
  end
  
  def name
    @data["Name"]
  end

  def provisioned_devices
    parse
    @data["ProvisionedDevices"]
  end

  def team_name
    parse
    @data["TeamName"]
  end

  private 
  
  def parse
    return @data if @data

    `security cms -D -i "#{@provision_path}" > #{TEMP_PLIST}`

    # Get info from plist
    plist = CFPropertyList::List.new
    plist = CFPropertyList::List.new(:file => TEMP_PLIST)
    @data = CFPropertyList.native_types(plist.value)
  end

  def clean_up
    system "rm -rf #{TEMP_PLIST}"
  end
    
end
