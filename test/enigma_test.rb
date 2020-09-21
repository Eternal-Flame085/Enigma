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

		expected = {
     	encryption: "keder ohulw",
     	key: "02715",
     	date: "040895"
   	}

		assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
	end

	def test_decrypt
		enigma = Enigma.new

		expected = {
			decryption: "hello world",
			key: "02715",
			date: "040895"
		}

		assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
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

	def test_date_offset
		enigma = Enigma.new

		assert_equal ["4", "4", "0", "0"], enigma.date_offset("092120")
	end

	def test_key_combinations
		enigma = Enigma.new

		assert_equal ["02", "27" , "71", "15"], enigma.key_combinations("02715")
	end

	def test_generate_key
		enigma = Enigma.new

		assert_includes 0..9999, enigma.generate_key.to_i
		assert_equal "0", enigma.generate_key[0]
	end

	def test_encrypter
		enigma = Enigma.new

		keys = enigma.key_combinations("02715")
		offsets = enigma.date_offset("040895")

		assert_equal "keder ohulw", enigma.encrypter("hello world", keys, offsets)
		assert_equal "keder ohulw#@!#", enigma.encrypter("hello world#@!#", keys, offsets)
	end

	def test_decrypter
		enigma = Enigma.new

		keys = enigma.key_combinations("02715")
		offsets = enigma.date_offset("040895")

		assert_equal "hello world", enigma.decrypter("keder ohulw", keys, offsets)
		assert_equal "hello world!@$", enigma.decrypter("keder ohulw!@$", keys, offsets)
	end

	def test_alphabet_index_finder
		enigma = Enigma.new

		assert_equal 10, enigma.alphabet_index_finder(3, "h", "encrypt")
		assert_equal 7, enigma.alphabet_index_finder(3, "k", "decrypt")
	end

	def test_encrypt_shift
		enigma = Enigma.new

		assert_equal 10, enigma.encrypt_shift(3, "h")
	end

	def test_decrypt_shift
		enigma = Enigma.new

		assert_equal 7, enigma.decrypt_shift(3, "k")
	end
end
