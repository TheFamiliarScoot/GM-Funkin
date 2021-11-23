var multX = 90 * scale;
var multY = 180 * scale;
var length = array_length(choices) - 1;
for (var i = 0; i < array_length(choices); i += 1) {
	var notselected = i != selection;
	draw_font_text(choices[i],x+curdrawoffsetX+(i*multX),y+curdrawoffsetY+(i*multY),true,40,scale,false,notselected ? 0.5 : 1);
}
if input_check_pressed(vk_up, gp_padu) {
	selection += 1;
	if selection > length { selection = 0; }
	audio_play_sound(snd_menu_scroll,0,false);
}
if input_check_pressed(vk_down, gp_padd) {
	selection -= 1
	if selection < 0 { selection = length; }
	audio_play_sound(snd_menu_scroll,0,false);
}
drawoffsetX = -(selection*multX);
drawoffsetY = -(selection*multY);
curdrawoffsetX += (drawoffsetX - curdrawoffsetX) * 0.1;
curdrawoffsetY += (drawoffsetY - curdrawoffsetY) * 0.1;