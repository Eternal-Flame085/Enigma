require './test/test_helper'
require 'date'
require './lib/enigma'

class EnigmaTest < Minitest::Test
	def test_it_exist
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
	end
end
