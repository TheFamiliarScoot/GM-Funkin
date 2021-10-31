if room = room_play {
	FMODGMS_Chan_RemoveChannel(deathmusic);
	FMODGMS_Snd_Unload(dsnd_end);
	FMODGMS_Snd_Unload(dsnd_loop);
}