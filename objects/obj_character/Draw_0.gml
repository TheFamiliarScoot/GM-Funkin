if no_antialiasing { gpu_set_texfilter(false); }
draw_self();
gpu_set_texfilter(opt.antialiasing);