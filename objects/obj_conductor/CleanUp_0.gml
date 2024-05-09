fmod_channel_control_stop(chi);
fmod_channel_control_stop(chv1);
fmod_channel_control_stop(chv2);
fmod_sound_release(ins);
if voc1 > -1 { fmod_sound_release(voc1); }
if voc2 > -1 { fmod_sound_release(voc2); }
ins = -1;
voc1 = -1;
voc2 = -1;
chi = -1;
chv1 = -1;
chv2 = -1;