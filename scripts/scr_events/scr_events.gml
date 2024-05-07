global.event_map = ds_map_create();
ds_map_add(global.event_map, "FocusCamera", event_focus_camera);
ds_map_add(global.event_map, "ChangeTime", event_change_time);

function handle_event(ev) {
	if ds_map_exists(global.event_map, ev.type) {
		var func = ds_map_find_value(global.event_map, ev.type);
		func(ev);
	}
}

function event_focus_camera(ev) {
	global.target = targets[ev.value.char];
}

function event_change_time(ev) {
	cond.bpm = ev.value.bpm;
	cond.timenumerator = ev.value.n;
	cond.timedenominator = ev.value.d;
	cond.crochet = 60 / cond.bpm;
}