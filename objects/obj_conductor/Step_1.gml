if !playing {
	return;	
}

stephit = false;
beathit = false;
if laststep != cstep { stephit = true; }
if lastbeat != cbeat { beathit = true; }
lastbeat = cbeat;
laststep = cstep;
