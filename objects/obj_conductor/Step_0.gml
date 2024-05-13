if !playing {
	return;	
}

var timeunit = FMOD_TIMEUNIT.MS;

// Events
var ev_length = array_length(events);
var i = 0;
repeat (ev_length) {
	var ev = events[i];
	if !ev.played && notepos >= ev.position {
		ev.played = true;
		if call_lua_event("onEvent", ev) {
			handle_event(id, ev);
		}
	}
	i++;
}

// Time Changes
var t_length = array_length(timechanges);
i = 0;
repeat (t_length) {
	var t = timechanges[i];
	if !t.played && notepos >= ev.position {
		t.played = true;
		bpm = t.bpm;
		timenumerator = t.n;
		timedenominator = t.d;
		crochet = 60 / bpm;
	}
	i++;
}

lastpos = songpos;
if !global.paused && window_has_focus() {
	if instrumental < 0 || countingdown {
		songpos += delta_time / 1000000;
	}
	else {
		songpos = fmod_channel_get_position(channel_inst, FMOD_TIMEUNIT.MS) / 1000;
	}	
}

if songpos >= 0 && countingdown {
	countingdown = false;
	if instrumental >= 0 {
		fmod_channel_control_set_paused(channel_inst, false);
		if channel_vocals[0] > -1 { fmod_channel_control_set_paused(channel_vocals[0], false); }
		if channel_vocals[1] > -1 { fmod_channel_control_set_paused(channel_vocals[1], false); }
		fmod_channel_set_position(channel_inst, 0, FMOD_TIMEUNIT.MS);
		if channel_vocals[0] > -1 { fmod_channel_set_position(channel_vocals[0], 0, FMOD_TIMEUNIT.MS); }
		if channel_vocals[1] > -1 { fmod_channel_set_position(channel_vocals[1], 0, FMOD_TIMEUNIT.MS); }
		audiovolume = 0.5;
	}
}

var sdelta = songpos - lastpos;
notepos = songpos * 1000;
gstep += sdelta / crochet;
gbeat += (sdelta / crochet) / timenumerator;
cbeat = floor(gbeat);
cstep = floor(gstep) % timenumerator;

// Conductor display
if beathit {
	if conductordisplay { audio_play_sound(sfx_beat,0,false); }
}
else if stephit && conductordisplay { audio_play_sound(sfx_bar,0,false); }

// Countdown
var c = abs(cstep);
if countingdown && c != count {
	switch c {
		case 0: audio_play_sound(snd_cd_three,3,false); break;
		case 1: audio_play_sound(snd_cd_two,2,false); break;
		case 2: audio_play_sound(snd_cd_one,1,false); break;
		case 3: audio_play_sound(snd_cd_go,0,false); break;
	}
	if !(c < 1) {
		instance_create_layer(global.view_width/2,global.view_height/2,"UI",obj_countdown,{countspr: c});
	}
}
count = c;

if instrumental >= 0 {
	// Time left
	if !countingdown {
		timeleft = (fmod_sound_get_length(instrumental, timeunit) - fmod_channel_get_position(channel_inst, timeunit)) / 1000;
	}
	
	// Audio volume
	fmod_channel_control_set_volume(channel_inst, audiovolume);
	if channel_vocals[0] > -1 { fmod_channel_control_set_volume(channel_vocals[0], !vocalsmuted[0]*audiovolume); }
	if channel_vocals[1] > -1 { fmod_channel_control_set_volume(channel_vocals[1], !vocalsmuted[1]*audiovolume); }

	// Pausing
	if !stepmode && !global.paused {
		fmod_channel_control_set_paused(channel_inst, !window_has_focus());
		if channel_vocals[0] > -1 { fmod_channel_control_set_paused(channel_vocals[0], !window_has_focus()); }
		if channel_vocals[1] > -1 { fmod_channel_control_set_paused(channel_vocals[1], !window_has_focus()); }
	}	
}