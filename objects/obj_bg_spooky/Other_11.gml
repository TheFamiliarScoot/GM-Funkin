/// @description Lightning

sprite_index = spr_halloweenbg_lightning;
image_index = 0;
audio_play_sound(sounds[irandom(array_length(sounds) - 1)], 0, false);
lightning_beat = floor(conductor.gbeat);
lightning_offset = irandom_range(8, 24);