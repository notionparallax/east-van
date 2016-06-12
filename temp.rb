

h_test_word = "van".upcase
v_test_word = "east".upcase

h_letters = h_test_word.length
v_letters = v_test_word.length

rad = 8
pad = 9
box = 50 # 4*rad

vll = (0) + pad
vlm = ((h_letters/2).floor * box) + pad
vrm = (vlm + box) + pad
vrr = (h_letters * box) + pad

htt = (0) + pad
htm = (box) + pad
hlm = (box * 2) + pad
hll = (v_letters * box) + pad

v_nudge = 7

blur=10

svg_head = "<svg width=\"#{vrr+(2*pad)}\" height=\"#{hll+(2*pad)}\" xmlns=\"http://www.w3.org/2000/svg\">"
svg_filter = "<filter id=\"blurMe\"><feGaussianBlur in=\"SourceGraphic\" stdDeviation=\"#{blur}\" /></filter>"
svg_bg = "<rect x=\"0\" y=\"0\" width=\"#{vrr+(2*pad)}\" height=\"#{hll+(2*pad)}\" fill=\"black\" />"

path = "M#{vll + rad} #{htm}"+ #1       
       "L #{vlm - rad} #{htm}"+ #2
       "A #{rad} #{rad}, 0, 0, 0, #{vlm} #{htm - rad}"+ #3
       "L #{vlm}  #{htt + rad}"+ #4
       "A #{rad} #{rad}, 0, 0, 1, #{vlm + rad} #{htt}"+ #5
       "L #{vrm-rad}  #{htt}"+ #6
       "A #{rad} #{rad}, 0, 0, 1, #{vrm} #{htt + rad}"+ #7
       "L #{vrm} #{htm - rad}"+ #8
       "A #{rad} #{rad}, 0, 0, 0, #{vrm + rad} #{htm}"+ #9
       "L #{vrr-rad} #{htm}"+ #10
       "A #{rad} #{rad}, 0, 0, 1, #{vrr} #{htm + rad}"+ #11
       "L #{vrr} #{hlm-rad}"+ #12
       "A #{rad} #{rad}, 0, 0, 1, #{vrr - rad} #{hlm}"+ #13
       "L #{vrm+rad} #{hlm}"+ #14
       "A #{rad} #{rad}, 0, 0, 0, #{vrm} #{hlm + rad}"+ #15
       "L #{vrm} #{hll-rad}"+ #16
       "A #{rad} #{rad}, 0, 0, 1, #{vrm-rad} #{hll}"+ #17
       "L #{vlm+rad} #{hll}"+ #18
       "A #{rad} #{rad}, 0, 0, 1, #{vlm} #{hll-rad}"+ #19
       "L #{vlm} #{hlm+rad}"+ #20
       "A #{rad} #{rad}, 0, 0, 0, #{vlm-rad} #{hlm}"+ #21
       "L #{vll+rad} #{hlm}"+ #22
       "A #{rad} #{rad}, 0, 0, 1,  #{vll} #{hlm-rad}"+ #23
       "L  #{vll} #{htm+rad}"+ #24
       "A #{rad} #{rad}, 0, 0, 1, #{vll + rad} #{htm}"

svg_path = "<path id=\"glow_path\" d=\"#{path}\" stroke=\"blue\" "+
           "fill=\"none\" stroke-width=\"2\" fill-opacity=\"0.5\" filter=\"url(#blurMe)\"></path>"+
           "<path id=\"main_path\" d=\"#{path}\" stroke=\"white\" "+
           "fill=\"none\" stroke-width=\"2\" fill-opacity=\"0.5\"></path>"


svg_text = ""
h_test_word.scan(/\w/).each_with_index do |letter, index|
  svg_text << "<text class=\"blur-text\"   text-anchor=\"middle\" x=\"#{vll + index*box + (box/2)}\" y=\"#{hlm - v_nudge}\" font-size=\"#{box}\" font-family=\"sans-serif\" fill=\"white\" filter=\"url(#blurMe)\">#{letter}</text>"
  svg_text << "<text class=\"bright-text\" text-anchor=\"middle\" x=\"#{vll + index*box + (box/2)}\" y=\"#{hlm - v_nudge}\" font-size=\"#{box}\" font-family=\"sans-serif\" fill=\"white\">#{letter}</text>"
end

v_test_word.scan(/\w/).each_with_index do |letter, index|
  unless index == 1
    svg_text << "<text class=\"blur-text\"   text-anchor=\"middle\" x=\"#{vlm + box/2}\" y=\"#{htt + (index*box)+box - v_nudge}\" font-size=\"#{box}\" font-family=\"sans-serif\" fill=\"white\" filter=\"url(#blurMe)\">#{letter}</text>"
    svg_text << "<text class=\"bright-text\" text-anchor=\"middle\" x=\"#{vlm + box/2}\" y=\"#{htt + (index*box)+box - v_nudge}\" font-size=\"#{box}\" font-family=\"sans-serif\" fill=\"white\">#{letter}</text>"
  end
end

svg = svg_head << svg_filter << svg_bg << svg_path << svg_text << "</svg>"
File.open("temp.svg", 'w') { |file| file.write svg }

puts "vll: " + vll.to_s
puts "vlm: " + vlm.to_s
puts "vrm: " + vrm.to_s
puts "vrr: " + vrr.to_s
puts "htt: " + htt.to_s
puts "htm: " + htm.to_s
puts "hlm: " + hlm.to_s
puts "hll: " + hll.to_s
