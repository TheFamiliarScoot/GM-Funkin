/// @description Insert description here
// You can write your code in this editor

if !selected {
	if input_check_pressed(vk_right) {
		selectedpack += 1;
		if selectedpack >= array_length(packinfo) {
			selectedpack = 0;	
		}
		audio_play_sound(snd_menu_scroll,0,false);
	}
	if input_check_pressed(vk_left) {
		selectedpack -= 1;
		if selectedpack < 0 {
			selectedpack = array_length(packinfo) - 1;	
		}
		audio_play_sound(snd_menu_scroll,0,false);
	}

	xoffset = lerp(xoffset, -room_width * selectedpack, d(0.125));	
}
else {
	xoffset = -room_width * selectedpack;	
}