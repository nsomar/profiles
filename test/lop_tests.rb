require 'minitest/autorun'
require 'profiles'

class LopTests < Minitest::Unit::TestCase

  def test_can_list_profiles
    puts `lop`
  end
end