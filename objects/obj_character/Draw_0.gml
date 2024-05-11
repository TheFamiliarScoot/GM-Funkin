if no_antialiasing { gpu_set_texfilter(false); }
if image_index > 1 && missed { image_blend = misscolor; }
draw_self();
image_blend = c_white;
gpu_set_texfilter(opt.antialiasing);