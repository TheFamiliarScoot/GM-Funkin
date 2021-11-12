// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_font_text(text, xx, yy, bold, spacing = 40, scale = 1, centered = false, alpha = 1) {
	var normchars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!.'”“?,:1234567890~=+-_*#@%$×/;()><^&|\\♥↓←↑→[]☻";
	var boldchars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var chars = "";
	

	
	var ctr = 0;
	var realtext = "";
	var fontsprite = noone;
	if bold { realtext = string_upper(text); fontsprite = spr_letters_bold; chars = boldchars; }
	else { realtext = text; fontsprite = spr_letters; chars = normchars; }
	
	var totallength = (spacing * string_length(realtext)) * scale;
	
	repeat string_length(realtext) {
		var curch = string_char_at(realtext,ctr + 1);
		var char = string_pos(curch,chars) - 1;
		
		var curx = xx + (ctr * spacing) * scale;
		
		if string_count(curch,chars) > 0 { draw_sprite_ext(
			fontsprite,
			char,
			centered ? curx - totallength / 2 : curx,
			yy,
			scale,
			scale,
			0,
			c_white,
			alpha
		); }
		++ctr;
	}
}

function draw_combo_numbers(t,xx,yy,scl) {
	var r = "";
	var c = "";
	
	for (var i = string_length(t); i > -1; i -= 1) {
		c = string_char_at(t,i);
		r += c;
	}
	
	for (var j = 1; j < string_length(r); j += 1) {
		c = string_char_at(r,j);
		draw_sprite_ext(spr_combo_num,real(c),x+((85*-j)*scl),yy,scl,scl,0,c_white,1);
	}
}