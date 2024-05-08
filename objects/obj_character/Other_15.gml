play_anim_d(id,down_miss_sprite != noone ? down_miss_sprite : down_sprite);
self.alarm[0] = d(game_get_speed(gamespeed_fps)/2);
self.holding = true;
self.missed = true;
play_miss_sfx();