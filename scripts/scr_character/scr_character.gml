function character_note_hit(char, note) {
	with char {
		var spr = [ left_sprite, down_sprite, up_sprite, right_sprite ];
		if note.alt {
			spr = [ left_alt_sprite, down_alt_sprite, up_alt_sprite, right_alt_sprite ];
		}
		play_anim_d(id,spr[note.type % 4]);
		alarm[0] = d(game_get_speed(gamespeed_fps)/2);
		holding = true;
		missed = false;
		if instance_exists(conductor) {
			conductor.vocalsmuted[playside] = false;	
		}
	}
}

function character_note_miss(char, note) {
	with char {
		var spr = [ left_sprite, down_sprite, up_sprite, right_sprite ];
		var mspr = [ left_miss_sprite, down_miss_sprite, up_miss_sprite, right_miss_sprite ];
		if mspr[note.type % 4] == noone {
			play_anim_d(id,spr[note.type % 4]);
		}
		else {
			play_anim_d(id,mspr[note.type % 4]);
		}
		alarm[0] = d(game_get_speed(gamespeed_fps)/2);
		holding = true;
		missed = true;
		if instance_exists(conductor) {
			conductor.vocalsmuted[playside] = true;	
		}
		play_miss_sfx();
	}
}