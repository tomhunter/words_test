# Run with: sequencer$ ruby lib/sequencer2.rb "dictionary words"
#
class Sequencer
  EXPORT_FILENAME_SEQUENCES = 'sequences'.freeze
  EXPORT_FILENAME_WORDS = 'words'.freeze

  def initialize(dictionary_filename)
    @filename = dictionary_filename
  end

  def call
    sequencer_result = sequence_dictionary
    export(sequencer_result)
  end

  private

  attr_accessor :filename

  # Export the sequences & words data
  #
  def export(result)
    File.open(EXPORT_FILENAME_SEQUENCES, "w+") do |sequences_file|
      sequences_file.puts(result.keys)
    end

    File.open(EXPORT_FILENAME_WORDS, "w+") do |words_file|
      words = result.values.map {|v| v[:word] }
      words_file.puts(words)
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
    puts "  Reading from file: #{filename}\n"

    begin
      file = File.open(filename)
    rescue
      puts "  ERROR: Unable to open file"
      exit
    end
  end

  # Return result of parsing the dictionary data in the following format:
  #
  #   {
  #     'carr' => { word: 'carrot', count: 1 },
  #     'arro' => { word: 'carrot', count: 1 },
  #     'rrot' => { word: 'carrot', count: 1 }
  #   }
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
    bucket
  end
end

filename = ARGV[0] || "dictionary words" # use filename in exercise as default filename
Sequencer.new(filename).call
