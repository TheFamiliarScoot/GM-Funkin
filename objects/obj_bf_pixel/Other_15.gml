self.image_index = 0;
self.image_speed = 1;
self.sprite_index = down_miss_sprite;
self.alarm[0] = game_get_speed(gamespeed_fps)/2;
self.holding = true;
audio_play_sound(asset_get_index("snd_miss" + string(irandom_range(0,2))),0,false);