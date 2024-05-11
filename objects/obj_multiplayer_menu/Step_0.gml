if input_check_pressed(vk_escape) {
	if prompting_leave {
		instance_destroy(server);
		room_transition(room_menu);
	}
	else {
		prompting_leave = true;	
	}
}