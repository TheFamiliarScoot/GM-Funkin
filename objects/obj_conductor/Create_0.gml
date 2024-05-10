vocalsmuted = [false, false];

chi = fmod_system_play_sound(ins, true);
chv = [-1, -1];
if voc1 > -1 { chv1 = fmod_system_play_sound(voc1, true); }
if voc2 > -1 { chv2 = fmod_system_play_sound(voc2, true); }

audiovolume = 0;
lastbeat = 0;
laststep = 0;
slowmode = false;
conductordisplay = false;
countingdown = true;
stepmode = false;
count = -2;
targets = [ global.bfinstance, global.dadinstance, global.gfinstance ];
visualizer = instance_create_layer(0, 0, layer, obj_dsp_spectrum);