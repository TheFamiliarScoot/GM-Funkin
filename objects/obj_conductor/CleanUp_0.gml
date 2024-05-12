fmod_channel_control_stop(channel_inst);
fmod_channel_control_stop(channel_vocals[0]);
fmod_channel_control_stop(channel_vocals[1]);
fmod_sound_release(instrumental);
if vocals[0] > -1 { fmod_sound_release(vocals[0]); }
if vocals[1] > -1 { fmod_sound_release(vocals[1]); }