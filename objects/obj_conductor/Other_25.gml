/// @description Activate
if instrumental >= 0 {
	fmod_channel_control_set_paused(channel_inst, false);
	if channel_vocals[0] > -1 { fmod_channel_control_set_paused(channel_vocals[0], false); }
	if channel_vocals[1] > -1 { fmod_channel_control_set_paused(channel_vocals[1], false); }
}