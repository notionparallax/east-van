"use strict";

let h_test_word = "van".toUpperCase();
let v_test_word = "east".toUpperCase();
 
let h_letters = h_test_word.length;
let v_letters = v_test_word.length;
 
let rad = 8;
let pad = 9;
let box = 50;
 
let vll = (0) + pad;
let vlm = (Math.floor(h_letters/2) * box) + pad;
let vrm = (vlm + box) + pad;
let vrr = (h_letters * box) + pad;
 
let htt = (0) + pad;
let htm = (box) + pad;
let hlm = (box * 2) + pad;
let hll = (v_letters * box) + pad;
 
let v_nudge = 7;
 
let blur = 10;

let svg_head = `<svg width=\"${vrr+(2*pad)}\" height=\"${hll + (2 * pad)}\" xmlns=\"http://www.w3.org/2000/svg\">`;
let svg_filter = `<filter id=\"blurMe\"><feGaussianBlur in=\"SourceGraphic\" stdDeviation=\"${blur}\" /></filter>`;
let svg_bg = `<rect x=\"0\" y=\"0\" width=\"${vrr + (2 * pad)}\" height=\"${hll + (2 * pad)}\" fill=\"black\" />`;

let path = `M${vll + rad} ${htm}`+ //1       
           `L ${vlm - rad} ${htm}`+ //2
           `A ${rad} ${rad}, 0, 0, 0, ${vlm} ${htm - rad}`+ //3
           `L ${vlm}  ${htt + rad}`+ //4
           `A ${rad} ${rad}, 0, 0, 1, ${vlm + rad} ${htt}`+ //5
           `L ${vrm-rad}  ${htt}`+ //6
           `A ${rad} ${rad}, 0, 0, 1, ${vrm} ${htt + rad}`+ //7
           `L ${vrm} ${htm - rad}`+ //8
           `A ${rad} ${rad}, 0, 0, 0, ${vrm + rad} ${htm}`+ //9
           `L ${vrr-rad} ${htm}`+ //10
           `A ${rad} ${rad}, 0, 0, 1, ${vrr} ${htm + rad}`+ //11
           `L ${vrr} ${hlm-rad}`+ //12
           `A ${rad} ${rad}, 0, 0, 1, ${vrr - rad} ${hlm}`+ //13
           `L ${vrm+rad} ${hlm}`+ //14
           `A ${rad} ${rad}, 0, 0, 0, ${vrm} ${hlm + rad}`+ //15
           `L ${vrm} ${hll-rad}`+ //16
           `A ${rad} ${rad}, 0, 0, 1, ${vrm-rad} ${hll}`+ //17
           `L ${vlm+rad} ${hll}`+ //18
           `A ${rad} ${rad}, 0, 0, 1, ${vlm} ${hll-rad}`+ //19
           `L ${vlm} ${hlm+rad}`+ //20
           `A ${rad} ${rad}, 0, 0, 0, ${vlm-rad} ${hlm}`+ //21
           `L ${vll+rad} ${hlm}`+ //22
           `A ${rad} ${rad}, 0, 0, 1,  ${vll} ${hlm-rad}`+ //23
           `L  ${vll} ${htm+rad}`+ //24
           `A ${rad} ${rad}, 0, 0, 1, ${vll + rad} ${htm}`;

let svg_path = `<path id=\"glow_path\" d=\"${path}\" stroke=\"blue\" `+
               `fill=\"none\" stroke-width=\"2\" fill-opacity=\"0.5\" filter=\"url(#blurMe)\"></path>`+
               `<path id=\"main_path\" d=\"${path}\" stroke=\"white\" `+
               `fill=\"none\" stroke-width=\"2\" fill-opacity=\"0.5\"></path>`;


let svg_text = ""
for (let index = 0, len = h_test_word.length; index < len; index++) {
  let letter = h_test_word[index];
  svg_text += "<text class=\"blur-text\"   text-anchor=\"middle\" x=\"${vll + index*box + (box/2)}\" y=\"${hlm - v_nudge}\" font-size=\"${box}\" font-family=\"sans-serif\" fill=\"white\" filter=\"url(#blurMe)\">${letter}</text>";
  svg_text += "<text class=\"bright-text\" text-anchor=\"middle\" x=\"${vll + index*box + (box/2)}\" y=\"${hlm - v_nudge}\" font-size=\"${box}\" font-family=\"sans-serif\" fill=\"white\">${letter}</text>";
}

for (let index = 0, len = v_test_word.length; index < len; index++) {
  let letter = v_test_word[index];
  if(index !== 1){
    svg_text += "<text class=\"blur-text\"   text-anchor=\"middle\" x=\"${vlm + box/2}\" y=\"${htt + (index*box)+box - v_nudge}\" font-size=\"${box}\" font-family=\"sans-serif\" fill=\"white\" filter=\"url(#blurMe)\">${letter}</text>";
    svg_text += "<text class=\"bright-text\" text-anchor=\"middle\" x=\"${vlm + box/2}\" y=\"${htt + (index*box)+box - v_nudge}\" font-size=\"${box}\" font-family=\"sans-serif\" fill=\"white\">${letter}</text>";
  }
}

let svg = svg_head + 
          svg_filter + 
          svg_bg + 
          svg_path +
          svg_text +
          "</svg>"
//File.open("temp.svg", 'w') { |file| file.write svg }

console.log("vll:", vll);
console.log("vlm:", vlm);
console.log("vrm:", vrm);
console.log("vrr:", vrr);
console.log("htt:", htt);
console.log("htm:", htm);
console.log("hlm:", hlm);
console.log("hll:", hll);
