if is_leftright {
	if cond.stephit && !holding {
		if !danced {
			play_anim_d(id,danceleft_sprite);
		}
		else {
			play_anim_d(id,danceright_sprite);
		}
		danced = !danced;
		missed = false;
		self.lastStep = cond.cstep;
	}
}
else {
	if cond.stephit && !self.holding {
		if abs(cond.cstep) = 0 || abs(cond.cstep) = 2 {
			missed = false;
			play_anim_d(id,idle_sprite);
		}
		self.lastStep = cond.cstep;
	}
}