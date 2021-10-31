if is_leftright {
	if cond.stephit && !holding {
		if !danced {
			self.sprite_index = self.danceleft_sprite;	
		}
		else {
			self.sprite_index = self.danceright_sprite;	
		}
		danced = !danced;
		image_index = 0;
		d_image_speed = 1;
		self.lastStep = cond.cstep;
	}
}
else {
	if cond.stephit && !self.holding {
		if abs(cond.cstep) = 0 || abs(cond.cstep) = 2 {
			self.sprite_index = self.idle_sprite;
			self.image_index = 0;
			d_image_speed = 1;
		}
		self.lastStep = cond.cstep;
	}
}