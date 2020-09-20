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

	def test_encrypt
		enigma = Enigma.new

		expected1 = {
     	encryption: "keder ohulw",
     	key: "02715",
     	date: "040895"
   	}

		expected2 = {
     	encryption: "keder ohulw!",
     	key: "02715",
     	date: "040895"
   	}

		assert_equal expected1, enigma.encrypt("hello world", "02715", "040895")
		assert_equal expected2, enigma.encrypt("hello world!", "02715", "040895")
	end

	def test_decrypt
		enigma = Enigma.new

		expected1 = {
			decryption: "hello world",
			key: "02715",
			date: "040895"
		}

		expected2 = {
			decryption: "hello world!",
			key: "02715",
			date: "040895"
		}

		assert_equal expected1, enigma.decrypt("keder ohulw", "02715", "040895")
		assert_equal expected2, enigma.decrypt("keder ohulw!", "02715", "040895")
	end

	def test_encrypt_with_key
		enigma = Enigma.new
		enigma.stubs(:generate_date).returns("091920")

		expected = {
			encryption: "pib wdmczpu",
			key: "02715",
			date: "091920"
		}

		assert_equal expected, enigma.encrypt("hello world", "02715")
	end

	def test_encrypt_random_key
		enigma = Enigma.new
		enigma.stubs(:generate_key).returns("02715")
		enigma.stubs(:generate_date).returns("091920")

		expected = {
			encryption: "pib wdmczpu",
			key: "02715",
			date: "091920"
		}

		assert_equal expected, enigma.encrypt("hello world")
	end

	def test_decrypt_with_key
		enigma = Enigma.new

		expected = {
			decryption: "hello world",
			key: "02715",
			date: Date.today.strftime("%m%d%y")
		}
		encrypted = enigma.encrypt("hello world", "02715")

		assert_equal expected, enigma.decrypt(encrypted[:encryption], "02715")
	end
end
