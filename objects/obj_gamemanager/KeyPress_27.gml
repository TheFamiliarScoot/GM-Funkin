if room = room_play {
	FMODGMS_Chan_PauseChannel(chi);
	FMODGMS_Chan_PauseChannel(chv);
	room_transition(room_menu);	
}