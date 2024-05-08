play_anim_d(id,up_miss_sprite != noone ? up_miss_sprite : up_sprite);
self.alarm[0] = d(game_get_speed(gamespeed_fps)/2);
self.holding = true;
self.missed = true;
play_miss_sfx();