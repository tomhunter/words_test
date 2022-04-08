# Run with: sequencer$ ruby lib/sequencer2.rb "dictionary words"
#
class Sequencer
  EXPORT_FILENAME_SEQUENCES = 'sequences'.freeze
  EXPORT_FILENAME_WORDS = 'words'.freeze

  def initialize(dictionary_filename)
    @filename = dictionary_filename
  end

  def call
    sequences, words = sequence_dictionary
    export_array(EXPORT_FILENAME_SEQUENCES, sequences)
    export_array(EXPORT_FILENAME_WORDS, words)
  end

  private

  attr_accessor :filename

  # Export the array into file, one line per word
  #
  def export_array(filename, array)
    File.open(filename, "w+") do |file|
      file.puts(array)
    end
  end

  # Extract valid word from line given:
  #
  # * Convert to lowercase to ignore casing - Casing should not create a unique sequence.
  # * Use letters only - Numbers and special characters should not create a unique sequence.
  #
  def extract_word(line)
    line.chomp.downcase.gsub(/[^a-z]/, '')
  end

  # Return dictionary file. Exit program and display error if unable to open file.
  #
  def file
    filename = ARGV[0] || "dictionary words" # use filename in exercise as default

    begin
      file = File.open(filename)
    rescue
      puts "  ERROR: Unable to open file"
      exit
    end
  end

  # Return result of parsing the dictionary data in the following format:
  #
  # [
  #   ["carr", "give", "rots", "rows", "rrot", "rrow"],
  #   ["carrots", "give", "carrots", "arrows", "carrots", "arrows"]
  # ]
  #
  def sequence_dictionary
    bucket = {}

    file.each_line do |line|
      word = extract_word(line)
      next if word.size < 4

      (word.size-3).times do |n|
        sequence = word[n..(n+3)]

        if bucket.key?(sequence)
          bucket[sequence][:count] += 1
          next
        end

        bucket[sequence] = { word: word, count: 1 }
      end
    end

    bucket.reject! {|k,v| v[:count] > 1 }
    sequences = bucket.keys
    words = bucket.values.map {|v| v[:word] }

    [sequences, words]
  end
end

filename = ARGV[0] || "dictionary words" # use filename in exercise as default filename
Sequencer.new(filename).call
