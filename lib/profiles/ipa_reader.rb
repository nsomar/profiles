require 'pathname'
require 'base64'

UNZIP_DIR = "/tmp/unzip_temp"

class IpaReader

  def initialize(ipa_path)
    pn = Pathname.new(ipa_path)
    @ipa_path = pn.dirname
    @ipa_name = pn.basename
    @full_path = ipa_path
    
    at_exit { clean_up }
  end

  def provision_parser
    return @provision_parser if @provision_parser
    
    unzip_and_parse
    @provision_parser
  end

  def on_unzip(&block)
    @on_unzip = block
  end
  
  private 
  
  def unzip_and_parse
    unzip
    parse
  end
  
  def unzip
    @on_unzip.call if @on_unzip
    system "unzip #{@full_path} -d #{UNZIP_DIR} > /tmp/log.txt"
  end
  
  def parse
    provision_path = "#{UNZIP_DIR}/Payload/#{bundle_name}/embedded.mobileprovision"
    @provision_parser = ProvisionProfileParser.new provision_path
  end
  
  def bundle_name
    Dir.entries("#{UNZIP_DIR}/Payload").last
  end
  
  def clean_up
    system "rm -rf #{UNZIP_DIR}"
  end
end