require './test/test_helper'
require 'date'
require './lib/enigma'

class EnigmaTest < Minitest::Test
	def test_it_exist
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
	end

	def test_it_has_alphabet
		enigma = Enigma.new

		expected = ["a", "b", "c", "d", "e", "f", "g",
								"h", "i", "j", "k", "l", "m", "n",
								"o", "p", "q", "r", "s", "t", "u",
								"v", "w", "x", "y", "z", " "]
		assert_equal expected, enigma.alphabet
	end
end
