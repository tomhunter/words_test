# Run with: sequencer$ ruby lib/sequencer.rb "dictionary words"

filename = ARGV[0] || "dictionary words" # use filename in exercise as default
puts "  Reading from file: #{filename}\n"

begin
  dictionary_file = File.open(filename)
rescue
  puts "  ERROR: Unable to open file"
  exit
end

bucket = {}
line_count = 0 # Not necessary, informational purposes only

dictionary_file.each_line do |line|
  line_count += 1
  word = line.chomp.downcase.gsub(/[^a-z]/, '')
  next if word.size < 4

  puts "  #{word}"

  (word.size-3).times do |n|
    sequence = word[n..(n+3)]
    puts "     #{sequence}"

    if bucket.key?(sequence)
      bucket[sequence][:count] += 1
      next
    end

    bucket[sequence] = { word: word, count: 1 }
  end
end

bucket.reject! {|k,v| v[:count] > 1 }

puts "\n"
puts "Initial Line/Word count: #{line_count}"
puts "Unique Sequence count: #{bucket.size}"

File.open("sequences", "w+") do |sequences_file|
  sequences_file.puts(bucket.keys)
end

File.open("words", "w+") do |words_file|
  words = bucket.values.map {|v| v[:word] }
  words_file.puts(words)
end
