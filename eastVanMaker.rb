require 'json'

def bin_words(corpus_filename, output_filename)
  # prepare a hash with a list at each letter
  hbins = {}
  vbins = {}
  [*'a'..'z'].each do |letter|
    hbins[letter] = []
    vbins[letter] = []
  end

  # put the words that are appropriate into bins
  File.open("english-words/#{corpus_filename}", 'r').each_line do |word|
    word.strip!
    begin
      if /^[a-zA-Z]+$/.match word #check that the words are just letters
        
        if word.length > 4 #put into vbins
          v_hinge = word[1]
          vbins[v_hinge].push(word.strip)
        end 

        if word.length > 3 and word.strip.length.odd? #put into hbins
          h_hinge = word[word.length/2]
          hbins[h_hinge].push(word)
          # puts word.length, word
        end

      end
    rescue
      puts word
    end
  end

  File.open("h#{output_filename}.json", 'w') { |file| file.write(hbins.to_json) }
  File.open("v#{output_filename}.json", 'w') { |file| file.write(vbins.to_json) }
end

bin_words("words.txt", "words")
bin_words("simple_words.txt", "simple_words")

# quick test to check that it all works
# 5.times do
#   random_letter = [*'a'..'z'][rand(26)] 
#   hword = hbins[random_letter].shuffle[0]
#   vword = vbins[random_letter].shuffle[0]

#   puts "\n", random_letter, "H: " + hword, "V: " + vword
# end
