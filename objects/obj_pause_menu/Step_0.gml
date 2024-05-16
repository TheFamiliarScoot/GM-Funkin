if input_check_pressed(vk_enter, gp_face1) {
	switch selections.selection {
		case 0:
			with obj_gamemanager event_user(0);
			global.paused = false;
			break;
		case 1:
			room_transition(room_load);
			instance_destroy(selections);
			instance_destroy(id);
			break;
		case 2:
			room_transition(room_entrypoint);
			instance_destroy(selections);
			instance_destroy(id);
			break;
	}
}