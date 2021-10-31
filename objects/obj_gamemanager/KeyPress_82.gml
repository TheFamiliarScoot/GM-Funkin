if room = room_play && !global.paused && opt.retrykey {
	if !instance_exists(obj_gameover) {
		instance_create_layer(global.bfobject.x,global.bfobject.y,"Instances",obj_gameover);
	}
}