cond.stephit = false;
cond.beathit = false;
if laststep != cond.cstep { cond.stephit = true; }
if lastbeat != cond.cbeat { cond.beathit = true; }
lastbeat = cond.cbeat;
laststep = cond.cstep;
