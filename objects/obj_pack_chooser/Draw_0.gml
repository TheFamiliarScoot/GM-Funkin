/// @description Insert description here
// You can write your code in this editor

var plen = array_length(packinfo);
for (var i = 0; i < plen; i++) {
	var pinfo = packinfo[i];
	if pinfo.logo != noone {
		var sprw = sprite_get_width(pinfo.logo);
		var sprh = sprite_get_height(pinfo.logo);
		var xx = xoffset + (room_width * i) + (room_width / 2) - (sprw / 2);
		var yy = (room_height / 2) - (sprh / 2) - 80;
		var a = 1;
		if alarm[0] > 0 && alarm[0] % 3 == 0 {
			a = 0.5;
		}
		draw_sprite_ext(pinfo.logo, 0, xx, yy, 1, 1, 0, c_white, a);
	}
}
var selpinfo = packinfo[selectedpack];
draw_font_text(selpinfo.name, room_width / 2, room_height - 160, false, 40, 0.8, true);
draw_font_text(selpinfo.description, room_width / 2, room_height - 100, false, 40, 0.6, true);
