if instance_exists(conductor) {
	if is_leftright {
		if conductor.stephit && !holding {
			if !danced {
				play_anim_d(id,danceleft_sprite);
			}
			else {
				play_anim_d(id,danceright_sprite);
			}
			danced = !danced;
			missed = false;
			self.lastStep = conductor.cstep;
		}
	}
	else {
		if conductor.stephit && !self.holding {
			if abs(conductor.cstep) = 0 || abs(conductor.cstep) = 2 {
				missed = false;
				play_anim_d(id,idle_sprite);
			}
			self.lastStep = conductor.cstep;
		}
	}
}