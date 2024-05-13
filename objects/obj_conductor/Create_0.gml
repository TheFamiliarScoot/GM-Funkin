vocalsmuted = [false, false];

// if there's no instrumental, assume this conductor is just basic
if instrumental >= 0 {
	channel_inst = fmod_system_play_sound(instrumental, true);
	channel_vocals = [-1, -1];
	if vocals[0] > -1 { channel_vocals[0] = fmod_system_play_sound(vocals[0], true); }
	if vocals[1] > -1 { channel_vocals[1] = fmod_system_play_sound(vocals[1], true); }	
}
else {
	channel_inst = -1;
	channel_vocals = [-1, -1];
}

audiovolume = 0;
lastbeat = 0;
laststep = 0;
slowmode = false;
conductordisplay = false;
countingdown = true;
stepmode = false;
count = -2;
visualizer = instance_create_layer(0, 0, layer, obj_dsp_spectrum, {conductor: id});
playing = false;