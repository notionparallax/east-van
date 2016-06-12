require 'json'

# prepare a hash with a list at each letter
hbins = {}
vbins = {}
[*'a'..'z'].each do |letter|
  hbins[letter] = []
  vbins[letter] = []
end

# put the words that are appropriate into bins
File.open("english-words/words.txt", 'r').each_line do |word|
  word.strip!
  begin
    if /\w/.match word and not /[\d'\/]/.match word #check that the words are just letters
      
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

File.open("hwords.json", 'w') { |file| file.write(hbins.to_json) }
File.open("vwords.json", 'w') { |file| file.write(vbins.to_json) }

# quick test to check that it all works
5.times do
  random_letter = [*'a'..'z'][rand(26)] 
  hword = hbins[random_letter].shuffle[0]
  vword = vbins[random_letter].shuffle[0]

  puts "\n", random_letter, "H: " + hword, "V: " + vword
end
