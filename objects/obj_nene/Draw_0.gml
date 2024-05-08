if no_antialiasing { gpu_set_texfilter(false); }
draw_sprite(spr_nene_speaker_back, 0, x, y);
var vis = array_length(visualizers);
for (var i = 0; i < vis; i++) {
	draw_sprite(visualizers[i], 11 * (1 - band_buffer[i]), x, y);
}
draw_self();
gpu_set_texfilter(opt.antialiasing);