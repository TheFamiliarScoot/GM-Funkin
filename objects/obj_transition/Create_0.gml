event_inherited();
maxframes = game_get_speed(gamespeed_fps)/2;
in = true;
if instant {
	room_goto(roomtogoto);	
}
else {
	d_alarm[1] = maxframes;	
}