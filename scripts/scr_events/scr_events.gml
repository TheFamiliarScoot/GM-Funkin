global.event_map = ds_map_create();
ds_map_add(global.event_map, "FocusCamera", event_focus_camera);

function handle_event(c, ev) {
	if ds_map_exists(global.event_map, ev.type) {
		var func = ds_map_find_value(global.event_map, ev.type);
		func(c, ev);
	}
}

function event_focus_camera(c, ev) {
	global.target = c.targets[ev.value.char];
}