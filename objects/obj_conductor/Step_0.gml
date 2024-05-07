var timeunit = FMOD_TIMEUNIT.MS;
var ev_length = array_length(global.events);
var i = 0;
repeat (ev_length)
{
	var ev = global.events[i];
	if !ev.played && cond.notepos >= ev.position {
		ev.played = true;
		handle_event(ev);
	}
	i++;
}

cond.lastpos = cond.songpos;
if countingdown {
	cond.songpos += delta_time / 1000000;
}
else {
	cond.songpos = fmod_channel_get_position(chi, FMOD_TIMEUNIT.MS) / 1000;
}
if cond.songpos >= 0 && countingdown {
	countingdown = false;
	fmod_channel_control_set_paused(chi, false);
	if chv1 > -1 { fmod_channel_control_set_paused(chv1, false); }
	if chv2 > -1 { fmod_channel_control_set_paused(chv2, false); }
	fmod_channel_set_position(chi, 0, FMOD_TIMEUNIT.MS);
	if chv1 > -1 { fmod_channel_set_position(chv1, 0, FMOD_TIMEUNIT.MS); }
	if chv2 > -1 { fmod_channel_set_position(chv2, 0, FMOD_TIMEUNIT.MS); }
	audiovolume = 0.5;
}
var sdelta = cond.songpos - cond.lastpos;
cond.notepos = cond.songpos * 1000;
cond.gstep += sdelta / cond.crochet;
cond.gbeat += (sdelta / cond.crochet) / cond.timenumerator;
cond.cbeat = floor(cond.gbeat);
cond.cstep = floor(cond.gstep) % cond.timenumerator;

if !countingdown {
	cond.timeleft = fmod_sound_get_length(ins, timeunit) - fmod_channel_get_position(chi, timeunit);
}

/*
if cond.stephit {
	var inspos = fmod_channel_get_position(chi, timeunit);
	var voc1pos = chv1 > -1 ? fmod_channel_get_position(chv1, timeunit) : inspos;
	var voc2pos = chv2 > -1 ? fmod_channel_get_position(chv2, timeunit) : inspos;
	if voc1pos != inspos { fmod_channel_set_position(chv1, inspos, timeunit); }
	if voc2pos != inspos { fmod_channel_set_position(chv2, inspos, timeunit); }	
}
*/

// Conductor display
if cond.beathit {
	if conductordisplay { audio_play_sound(sfx_beat,0,false); }
}
else if cond.stephit && conductordisplay { audio_play_sound(sfx_bar,0,false); }

// Audio volume
fmod_channel_control_set_volume(chi, audiovolume);
if chv1 > -1 { fmod_channel_control_set_volume(chv1, !vocalsmuted[0]*audiovolume); }
if chv2 > -1 { fmod_channel_control_set_volume(chv2, !vocalsmuted[1]*audiovolume); }

// Pausing
if !stepmode && !global.paused {
	if !window_has_focus() {
		fmod_channel_control_set_paused(chi, true);
		if chv1 > -1 { fmod_channel_control_set_paused(chv1, true); }
		if chv2 > -1 { fmod_channel_control_set_paused(chv2, true); }
	}
	else {
		fmod_channel_control_set_paused(chi, false);
		if chv1 > -1 { fmod_channel_control_set_paused(chv1, false); }
		if chv2 > -1 { fmod_channel_control_set_paused(chv2, false); }
	}
}

// Countdown
var c = abs(cond.cstep);
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