/// @description Deactivate
if instrumental >= 0 {
	fmod_channel_control_set_paused(channel_inst, true);
	if channel_vocals[0] > -1 { fmod_channel_control_set_paused(channel_vocals[0], true); }
	if channel_vocals[1] > -1 { fmod_channel_control_set_paused(channel_vocals[1], true); }
}