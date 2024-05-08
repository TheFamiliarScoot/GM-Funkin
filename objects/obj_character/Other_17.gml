play_anim_d(id,right_miss_sprite != noone ? right_miss_sprite : right_sprite);
self.alarm[0] = d(game_get_speed(gamespeed_fps)/2);
self.holding = true;
self.missed = true;
play_miss_sfx();