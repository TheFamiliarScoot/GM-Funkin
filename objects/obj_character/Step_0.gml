if is_leftright {
	if cond.stephit && !holding {
		if !danced {
			play_anim_ind(id,danceleft_sprite,is_custom,true);
		}
		else {
			play_anim_ind(id,danceright_sprite,is_custom,true);
		}
		danced = !danced;
		self.lastStep = cond.cstep;
	}
}
else {
	if cond.stephit && !self.holding {
		if abs(cond.cstep) = 0 || abs(cond.cstep) = 2 {
			play_anim_ind(id,idle_sprite,is_custom,true);
		}
		self.lastStep = cond.cstep;
	}
}