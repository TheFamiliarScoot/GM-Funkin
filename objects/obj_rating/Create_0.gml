event_inherited();
image_xscale = 0.6;
image_yscale = 0.6;

d_hspeed = random_range(-0.75,0.75);
d_vspeed = -4;

d_alarm[0] = game_get_speed(gamespeed_fps)/2;

numstring = string(global.combo);

if global.combo < 10 { numstring = "0" + numstring; }
if global.combo < 100 { numstring = "0" + numstring; }