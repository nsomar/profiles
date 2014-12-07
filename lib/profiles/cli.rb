require 'thor'
require 'plist'
require 'CFPropertyList'
require 'nokogiri'
require 'profiles'

class Profiles::CLI < Thor

  option :t, :aliases => ["--team"],  :type => :boolean, desc: "Include 'iOSTeam Provisioning Profile' profiles"
  option :u, :aliases => ["--udid"], required: true, desc: "The UDID to search"
  desc "local", "search for a specific device"
  
  def local
    say "Parsing local provision profiles\n\n"
    udid = options[:u]
    
    profiles = ProfilesUtils.search_local_provisions(udid, options[:t])
    
    if (profiles.count == 0)
      say "No profile containing #{udid} UDID found", :red
    else
      say "Found #{profiles.count} profiles containing #{options[:u]}", :green
      profiles.sort.each { |item| say item}
    end
    
  end
  
  option :p, :aliases => ["--path"], required: true, desc: "Path of the IPA"
  option :u, :aliases => ["--udid"], required: true, desc: "The UDID to search"
  desc "ipa", "search for a specific device"

  def ipa
    udid = options[:u]
    reader = IpaReader.new(options[:p])
    
    reader.on_unzip { puts "Unzipping ipa file"}
    
    parser = reader.provision_parser
        
    if parser.provisioned_devices.include?(udid)
        say "#{udid} UDID found", :green
    else 
        say "#{udid} UDID not found", :red
    end
  end

end