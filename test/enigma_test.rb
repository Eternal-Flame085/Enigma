require "./test/test_helper"
require "./lib/Enigma"

class EnigmaTest < Minitest::Test
	def test_it_exist
    enigma = Enigma.new

    assert_instance_of Engima, enigma
	end
end
