require 'thor'
require 'plist'
require 'CFPropertyList'
require 'nokogiri'
class Profiles::CLI < Thor

  option :no_team,  :type => :boolean, desc: "Remove 'iOSTeam Provisioning Profile' profiles"
  desc "device UDID", "search for a specific device"
  def device(device)

    containing_device = Set.new
    computer_provisions.each do |file|
      contains = open(file, :encoding => "UTF-8") { |f| f.read[device] }
      next unless contains
      containing_device << file
    end

    provision_names = containing_device.map do |file|
      profile_name(file)
    end

    say "Found #{provision_names.count} profiles containing #{device}:", :green

    provision_names.reject! { |item| item[/iOSTeam Provisioning Profile.*/] } if options[:no_team]

    provision_names.sort.each { |item| say item}
  end

  private

  def computer_provisions
    Dir["#{PROFILE_PATHS}/*"].grep (/.*.mobileprovision/)
  end

  def profile_name(provisioning_profile_path)
    profile_contents = File.open(provisioning_profile_path).read
    profile_contents = profile_contents.slice(profile_contents.index('<?'), profile_contents.length)
    doc = Nokogiri.XML(profile_contents)
    doc.xpath('//key[text()="Name"]')[0].next_element.text
  end
end

PROFILE_PATHS = "/Users/omarsubhiabdelhafith/Library/MobileDevice/Provisioning Profiles"
