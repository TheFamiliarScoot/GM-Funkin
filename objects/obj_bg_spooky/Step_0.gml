if conductor.beathit {
	if irandom(10) == 0 && floor(conductor.cbeat) > (lightning_beat + lightning_offset) {
		event_user(1);	
	}
}